-- PostgreSQL Schema for Asofe

-- Enum types for account status and verification status
CREATE TYPE account_status AS ENUM ('active', 'inactive', 'suspended');
CREATE TYPE verification_status AS ENUM ('pending', 'verified', 'rejected');

-- Customers table
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    account_status account_status NOT NULL DEFAULT 'active',
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT (CURRENT_TIMESTAMP),
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT (CURRENT_TIMESTAMP)
);

-- Designers table
CREATE TABLE designers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    verification_status verification_status NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT (CURRENT_TIMESTAMP),
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT (CURRENT_TIMESTAMP)
);

-- Waitlist table
CREATE TABLE waitlist (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id),
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT (CURRENT_TIMESTAMP)
);

-- Admins table
CREATE TABLE admins (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT (CURRENT_TIMESTAMP),
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT (CURRENT_TIMESTAMP)
);

-- Indexes for performance
CREATE INDEX idx_customers_email ON customers(email);
CREATE INDEX idx_designers_email ON designers(email);
CREATE INDEX idx_waitlist_customer_id ON waitlist(customer_id);

-- Database Views
CREATE VIEW active_customers AS
SELECT * FROM customers WHERE account_status = 'active';

CREATE VIEW verified_designers AS
SELECT * FROM designers WHERE verification_status = 'verified';
