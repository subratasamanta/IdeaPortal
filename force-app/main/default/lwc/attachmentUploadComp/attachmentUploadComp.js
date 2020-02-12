import { LightningElement,api } from 'lwc';
// imported to show toast messages
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class FileUploadLWCdemo extends LightningElement {
    
      // eslint-disable-next-line no-undef
    @api recordId;
    //To fetch the Idea Id from URL
    connectedCallback(){
       const newURL = new URL(window.location.href).searchParams;
       this.recordId=newURL.get('IdeaId');
    }
    // Accepted format of files need to be uploaded
    get acceptedFormats() {
        return ['.pdf', '.png','.jpg','.jpeg'];
    }

    // Get the list of uploaded files
    handleUploadFinished(event) {
        let strFileNames = '';
        const uploadedFiles = event.detail.files;

        for(let i = 0; i < uploadedFiles.length; i++) {
            strFileNames += uploadedFiles[i].name + ', ';
        }
        //To show the success Message
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success!!',
                message: strFileNames + ' Files uploaded Successfully!!!',
                variant: 'success',
            }),
        );
    }
}