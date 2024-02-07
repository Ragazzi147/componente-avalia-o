import { LightningElement, api } from 'lwc';
import getAvaliacoes from '@salesforce/apex/AvaController.getAvaliacoes';
import getMediaNotas from '@salesforce/apex/AvaController.getMediaNotas';
import getUserDetails from '@salesforce/apex/AvaController.getUserDetails';

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
        this.retrieveDetails();

    }

    retrieveDetails() {
        getUserDetails()
            .then(result => {
                this.userName = result;
            })
            .catch(error => {
                console.error('error', error);
            })
    }
    
    // @api
    // refreshData(){
    //     this.connectedCallback();
    // }

 
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