import { LightningElement, api } from 'lwc';
import inserirAvaliacao from '@salesforce/apex/AvaController.inserirAvaliacao';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'

export default class AvaNota extends LightningElement {
    titulo = '';
    descricao = '';
    value = '';
    nota = '';
    @api recordId;

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


    handleClick() {

        inserirAvaliacao({ titulo: this.titulo, descricao: this.descricao, nota: this.nota, accountId: this.recordId })
            .then(result => {
                console.log('Inserção bem-sucedida:', result);

                // Emitir um evento personalizado para notificar outros componentes
                this.dispatchEvent(
                    new ShowToastEvent({
                    titulo: `Sucesso`,
                    message: `Avaliação criada`,
                    variant: `sucess`
                })
                );
            })
            .catch(error => {
                console.error('Erro ao inserir:', error);
            });
        console.log('recordId= ' + this.recordId);
    }

}