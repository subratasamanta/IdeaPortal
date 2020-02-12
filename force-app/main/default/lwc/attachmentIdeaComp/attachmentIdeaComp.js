/* eslint-disable no-console */
/* eslint-disable no-alert */
import { LightningElement,track,api } from 'lwc';
import releatedFiles from '@salesforce/apex/FileUploadClass.releatedFiles';
import downloadURL from '@salesforce/apex/FileUploadClass.getDownloadURL';
import deleteAttachment from '@salesforce/apex/FileUploadClass.deleteAttachment';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';


const actions = [
    { label: 'Download', name: 'Download' },
    { label: 'Delete', name: 'Delete' },
];

const columns = [
    {label: 'File Name', fieldName: 'title'},
    {label: 'Owner', fieldName: 'ownerName'},
    {label: 'Last Modified', fieldName: 'lastModDate',type:"date"},
    {
        type: 'action',
        typeAttributes: { rowActions: actions },
    },
];

export default class AttachmentIdeaComp extends NavigationMixin(LightningElement) {
    @api recordId;
    @track columns = columns;
    @track data = [];
    @track fileName = ''; 
    @track contentVerId;
    @track conDocIdList;
    @track recordsFound = false;

    connectedCallback() {
        this.getRelatedFiles();
    }
    
    
    getRelatedFiles() {
        const newURL = new URL(window.location.href).searchParams;
        this.recordId=newURL.get('IdeaId');
         releatedFiles({idParent: this.recordId})
         .then(result => {
            if(result.length > 0){
                this.data = result;
                this.recordsFound = true;
            }
         })
         .catch(error => {
             this.dispatchEvent(
                 new ShowToastEvent({
                     title: 'Error!!',
                     message: error.message,
                     variant: 'error',
                 }),
             );
         });
     
     }

    handleRowAction(event){
        const actionName = event.detail.action.name;
        const row = event.detail.row;

        console.log(JSON.stringify(row));
        //alert('JSON.stringify(row) '+ JSON.stringify(row));
        
        switch (actionName) {
            case 'Download':
                this.downloadAttachment(row.ContentDocumentId);
                break;
            case 'Delete':
                 this.deleteDBRow(row.ContentDocumentId);
                break;
            default:
        }
    }

    downloadAttachment(contentDocId){
        downloadURL({contentDocId : contentDocId})
                .then(result => {
                    window.open(result);
                })
                .catch(error => {
                    this.error = error;
                });
    }


    deleteDBRow(contentDocId){      
        deleteAttachment({atchId : contentDocId})
                .then(result => {
                    if(result){ 
                        this.deleteRow(contentDocId);
                    }
                })
                .catch(error => {
                    this.error = error;
                });
    }

    deleteRow(contentDocId) {
        const  id  = contentDocId;
        const index = this.findRowIndexById(id);
        if (index !== -1) {
            this.data = this.data
                .slice(0, index)
                .concat(this.data.slice(index + 1));
        }
    }

    findRowIndexById(id) {
        let ret = -1;
        this.data.some((row, index) => {
            if (row.ContentDocumentId === id) {
                ret = index;
                return true;
            }
            return false;
        });
        return ret;
    } 
}