import { LightningElement, api } from 'lwc';
import getAvaliacoes from '@salesforce/apex/AvaController.getAvaliacoes';
import getMediaNotas from '@salesforce/apex/AvaController.getMediaNotas';


const columns = [
    { label: 'Nome do Avaliador', fieldName: 'userName'},
    { label: 'Título', fieldName: 'titulo' },
    { label: 'Descrição', fieldName: 'descricao' },
    { label: 'Nota', fieldName: 'nota' }
];

export default class AvaTabela extends LightningElement {
    @api recordId;
    avaliacoes = [];
    mediaNotas;
  

    columns = columns;

    connectedCallback() {
       
        this.retrieveRecordAvaliacao();
        this.retrieveMediaNotas();
       
        console.log('recordId: ', this.recordId);
    }

    
    @api
    refreshData(){
        this.connectedCallback();
    }

 
    retrieveRecordAvaliacao() {
        getAvaliacoes({ accountId: this.recordId })
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
        
        return this.avaliacoes != 0;
    }
}