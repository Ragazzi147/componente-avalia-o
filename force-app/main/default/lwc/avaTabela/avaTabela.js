import { LightningElement, wire, api } from 'lwc';
import getAvaliacoes from '@salesforce/apex/AvaController.getAvaliacoes';

const columns = [
    { label: 'Título', fieldName: 'Name' },
    { label: 'Descrição', fieldName: 'Descricao__c' },
    { label: 'Nota', fieldName: 'Nota__c' },
];

export default class AvaTabela extends LightningElement {
    @api recordId;
    avaliacoes = [];
    columns = columns;

    connectedCallback() {
        this.retriveRecordAvaliacao();
      }

    

    retriveRecordAvaliacao(){
        getAvaliacoes({recordId: this.recordId})
        .then(result => {
            this.avaliacoes = result;
        }
        )
    }

    get getRecordsData() {
        return this.avaliacoes.length!=0;
      }

    
    

}
