/* eslint-disable no-unused-vars */
import { LightningElement,track } from 'lwc';

export default class AttachmentButtonComp extends LightningElement {
  

    @track fileName = '';
    @track showLoadingSpinner = false;
    @track isTrue = false;    
    filesUploaded = [];
    file; 
    MAX_FILE_SIZE = 1500000;

  connectedCallback() {
  }

// getting file 
handleFilesChange(event) {
    if(event.target.files.length > 0) {
        this.filesUploaded = event.target.files;
        this.fileName = event.target.files[0].name;
    }
}

handleSave() {
    if(this.filesUploaded.length > 0) {
      this.uploadHelper();
    }
    else {
        this.fileName = 'Please select file to upload!!';
    }
}
uploadHelper() {
  this.file = this.filesUploaded[0];
 if (this.file.size > this.MAX_FILE_SIZE) {
      window.console.log('File Size is to long');
      return ;
  }  
  // create a FileReader object 
  this.fileReader= new FileReader();
  // set onload function of FileReader object  
  this.fileReader.onloadend = (() => {
      this.fileContents = this.fileReader.result;
      let base64 = 'base64,';
      this.content = this.fileContents.indexOf(base64) + base64.length;
      this.fileContents = this.fileContents.substring(this.content);
      
      // call the uploadProcess method 
      this.saveToFile();
  });

  this.fileReader.readAsDataURL(this.file);
}

// Calling apex class to insert the file
saveToFile(event) {
    const fname = this.file.name;
    const fContent = encodeURIComponent(this.fileContents);
    const valueChangeEvent = new CustomEvent("valuechange", {
      detail : {fname,fContent}    
    });
    this.dispatchEvent(valueChangeEvent);     
}
}