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

    @wire(getAvaliacoes, { accountId: '$recordId' })
    wiredAvaliacoes({ error, data }) {
        if (data) {
            this.avaliacoes = data;
        } else if (error) {
            console.error('Erro ao obter avaliações:', error);
        }
    }
}
