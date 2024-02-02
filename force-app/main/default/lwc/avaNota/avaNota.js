import { LightningElement, track } from 'lwc';
import inserirAvaliacao from '@salesforce/apex/AvaController.inserirAvaliacao';

export default class AvaNota extends LightningElement {
    @track titulo = '';
    @track descricao = '';
    @track value = '';

    get options() {
        return [
            { label: '1', value: '1' },
            { label: '2', value: '2' },
            { label: '3', value: '3' },
            { label: '4', value: '4' },
            { label: '5', value: '5' },
        ];
    }

    handleChange(event) {
        this.value = event.detail.value;
    }

    contactChangeVal(event) {
        if (event.target.name === 'titulo') {
            this.titulo = event.target.value;
        } else if (event.target.name === 'descricao') {
            this.descricao = event.target.value;
        }
    }

    handleClick() {
        inserirAvaliacao({ titulo: this.titulo, descricao: this.descricao, nota: this.value })
            .then(result => {
                console.log('Inserção bem-sucedida:', result);

                // Emitir um evento personalizado para notificar outros componentes
                const successEvent = new CustomEvent('avaliacaoadicionada', {
                    detail: result
                });
                this.dispatchEvent(successEvent);
            })
            .catch(error => {
                console.error('Erro ao inserir:', error);
            });
    }
}
