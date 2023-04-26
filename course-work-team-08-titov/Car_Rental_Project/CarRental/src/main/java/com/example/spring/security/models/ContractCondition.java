package com.example.spring.security.models;

public enum ContractCondition {
    NOT_CONFIRMED ("Не подтверждён"),
    CONFIRMED ("Подтверждён"),
    CANCELED ("Отменён"),
    WORKING ("Действует"),
    COMPLETED ("Завершён"),
    AWAITING_PAYMENT_FINE("Ожидает оплаты штрафа");

    private String title;

    ContractCondition(String title) {
        this.title = title;
    }

    public String getTitle() {
        return title;
    }

        @Override
        public String toString() {
            return title;
        }
}
