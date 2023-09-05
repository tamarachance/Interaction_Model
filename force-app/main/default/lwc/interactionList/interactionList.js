import { LightningElement, wire, track} from 'lwc';
import getInteractions from '@salesforce/apex/InteractionController.getInteractions';

const COLUMNS = [
    { label: 'Interaction Name', fieldName: 'Name', type: 'text' },
    { label: 'Created Date', fieldName: 'CreatedDate', type: 'date' },
    { label: 'Related Customer', fieldName: 'customerName', type: 'text', typeAttribute: {linkify: 'true'}} 
      
];

export default class InteractionList extends LightningElement {
    columns = COLUMNS;
   @track interactions = [];

    @wire(getInteractions) //interactions;
    wiredInteractions({error, data}) {
      console.log(data);
      if (error) {
          // Handle error
      } else if (data) {
          // Process record data
          let newData = [];
          data.forEach(record =>{
            let recordData = {};
            if(record.Contact__c){
              recordData.customerName = record.Contact__r.Name;
              recordData.Name = record.Name;
              recordData.CreatedDate = record.CreatedDate;

              newData.push(recordData);
            }
            else if(record.Lead__c){
              recordData.customerName = record.Lead__r.Name;
              recordData.Name = record.Name;
              recordData.CreatedDate = record.CreatedDate;

              newData.push(recordData);
            }
            else {
              recordData.customerName = 'No Data Available';
              recordData.Name = record.Name;
              recordData.CreatedDate = record.CreatedDate;

              newData.push(recordData);
            }
          })
        console.log(newData);
        this.interactions = newData;
        console.log(this.interactions);
      }
  }
}