CREATE TABLE `Users`(
    `id` CHAR(36) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`id`)
);
ALTER TABLE
    `Users` ADD UNIQUE `users_email_unique`(`email`);
CREATE TABLE `Accounts`(
    `id` CHAR(36) NOT NULL,
    `user_id` CHAR(36) NOT NULL,
    `type` ENUM(
        'Cash',
        'Accounts',
        'Card',
        'Debit Card',
        'Savings',
        'Top-up/Prepaid',
        'Investments',
        'Overdrafts',
        'Loan',
        'Insurance',
        'Others'
    ) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `amount` DECIMAL(15, 2) NOT NULL DEFAULT 0,
    PRIMARY KEY(`id`)
);
CREATE TABLE `Category`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id` CHAR(36) NOT NULL,
    `name` VARCHAR(255) NOT NULL
);
ALTER TABLE
    `Category` ADD UNIQUE `category_user_id_name_unique`(`user_id`, `name`);
CREATE TABLE `Transactions`(
    `id` CHAR(36) NOT NULL,
    `type` ENUM('Income', 'Expense') NOT NULL,
    `user_id` CHAR(36) NOT NULL,
    `amount` DECIMAL(15, 2) NOT NULL DEFAULT 0,
    `account_id` CHAR(36) NOT NULL,
    `category_id` INT UNSIGNED NOT NULL,
    `date` DATE NOT NULL,
    `description` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`id`)
);
ALTER TABLE
    `Accounts` ADD CONSTRAINT `accounts_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `Users`(`id`);
ALTER TABLE
    `Category` ADD CONSTRAINT `category_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `Users`(`id`);
ALTER TABLE
    `Transactions` ADD CONSTRAINT `transactions_account_id_foreign` FOREIGN KEY(`account_id`) REFERENCES `Accounts`(`id`);
ALTER TABLE
    `Transactions` ADD CONSTRAINT `transactions_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `Users`(`id`);
ALTER TABLE
    `Transactions` ADD CONSTRAINT `transactions_category_id_foreign` FOREIGN KEY(`category_id`) REFERENCES `Category`(`id`);