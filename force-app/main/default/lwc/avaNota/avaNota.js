import { LightningElement, api } from 'lwc';
import inserirAvaliacao from '@salesforce/apex/AvaController.inserirAvaliacao';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import getUserDetails from '@salesforce/apex/AvaController.getUserDetails';

export default class AvaNota extends LightningElement {
    titulo = '';
    descricao = '';
    value = '';
    nota = '';
    @api recordId;
    userName;


    connectedCallback() {
        this. retrieveDetails();
    }


    get options() {
        return [
            { label: '1', value: '1' },
            { label: '2', value: '2' },
            { label: '3', value: '3' },
            { label: '4', value: '4' },
            { label: '5', value: '5' },
        ];
    }

    contactChangeVal(event) {
        const field = event.target.name;
        if (field) {
            this[field] = event.target.value
        }


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


   async handleClick() {
        console.log(this.recordId);
        const resultado = await inserirAvaliacao({ titulo: this.titulo, descricao: this.descricao, nota: this.nota, accountId: this.recordId })
            .then(result => {
                console.log('Inserção bem-sucedida:', result);

                // Emitir um evento personalizado para notificar outros componentes
                this.dispatchEvent(
                    new ShowToastEvent({
                        titulo: `Sucesso`,
                        message: `Avaliação criada`,
                        variant: `success`
                    })
                );
            })
            .catch(error => {
                console.error('Erro ao inserir:', error);
            });
        console.log('recordId= ' + this.recordId);
        if(resultado){
            const avaTab = this.template.querySelector('c-ava-tabela');
            if(avaTab) {
                avaTab.refreshData();
            }
        }
    }
}