import { LightningElement,api } from 'lwc';
import doSubscribe from '@salesforce/apex/SubscribeObjCls.doSubscribe';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'

export default class SubscriptionComp extends LightningElement {
    @api targetObjectId;    
    @api buttonLabel ='Subscribe';    
    handleClick(){
        doSubscribe({ targetObjectId : this.targetObjectId,buttonLabel : this.buttonLabel })
            .then(result => {                
                const event = new ShowToastEvent({
                    message: this.buttonLabel+'d successfully!',
                    variant:'success'
                });
                this.dispatchEvent(event);
                this.changeButtonLabel();
            })
            .catch(error => {
            });
    }
    changeButtonLabel(){
        if(this.buttonLabel =='Subscribe'){
            this.buttonLabel = 'Unsubscribe';
        }   
        else{
            if(this.buttonLabel == 'Unsubscribe'){
                this.buttonLabel = 'Subscribe';
            }
        }
    }
}