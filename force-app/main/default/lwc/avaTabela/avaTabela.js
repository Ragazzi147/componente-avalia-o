import { LightningElement, api } from 'lwc';
import getAvaliacoes from '@salesforce/apex/AvaController.getAvaliacoes';
import getMediaNotas from '@salesforce/apex/AvaController.getMediaNotas';

const columns = [
    { label: 'Título', fieldName: 'Name' },
    { label: 'Descrição', fieldName: 'Descricao__c' },
    { label: 'Nota', fieldName: 'nota__c' }
];

export default class AvaTabela extends LightningElement {
    @api recordId;
    avaliacoes = [];
    mediaNotas;

    columns = columns;

    connectedCallback() {
       
        this.retrieveRecordAvaliacao();
        this.retrieveMediaNotas();

    }

    refreshTable() {
        this.connectedCallback();
    }

    retrieveRecordAvaliacao() {
        getAvaliacoes({ recordId: this.recordId })
            .then(result => {
                this.avaliacoes = result;
            })
            .catch(error => {
                console.error('Error retrieving evaluations:', error);
            });
    }

    retrieveMediaNotas() {
        getMediaNotas({ recordId: this.recordId })
            .then(result => {
                this.mediaNotas = result;
            })
            .catch(error => {
                console.error('Error retrieving average nota:', error);
            });
    }

    get getRecordsData() {
        
        return this.avaliacoes !== 0;
    }
}