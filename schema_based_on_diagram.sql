CREATE DATABASE clinic;
CREATE TABLE patients(
    id BIGSERIAL NOT NULL,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    PRIMARY KEY(id)
);
CREATE TABLE medical_histories (
  id BIGSERIAL NOT NULL PRIMARY KEY,
  admitted_at TIMESTAMP NOT NULL,
  patient_id INT REFERENCES patients(id),
  status VARCHAR(100),
  CONSTRAINT idx_patient_id FOREIGN KEY (patient_id) REFERENCES patients(id)
);
CREATE INDEX idx_patient_id ON medical_histories (patient_id);

CREATE TABLE invoices (
 id BIGSERIAL NOT NULL PRIMARY KEY, 
 total_amount DECIMAL NOT NULL,
 generated_at TIMESTAMP,
 payed_at TIMESTAMP,
 medical_history_id INT REFERENCES medical_histories(id),
 CONSTRAINT fk_medical_history_id FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
);
CREATE INDEX idx_medical_history_id ON invoices (medical_history_id);

CREATE TABLE treatments (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    type VARCHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL,
    medical_history_id INT REFERENCES medical_histories(id)
);

CREATE TABLE invoice_items (
    id BIGSERIAL NOT NULL,
    unit_price DECIMAL NOT NULL,
    Quantity INT,
    total_price DECIMAL,
    invoice_id INT REFERENCES invoices (id),
    treatment_id INT REFERENCES treatments (id),
    PRIMARY KEY(id)
);

CREATE INDEX idx_invoice_items_invoice_treatment_id 
ON invoice_items (invoice_id, treatment_id);

CREATE TABLE medical_history_treatments (
  medical_history_id BIGINT NOT NULL REFERENCES medical_histories(id),
  treatment_id BIGINT NOT NULL REFERENCES treatments(id),
  PRIMARY KEY(medical_history_id, treatment_id),
  CONSTRAINT fk_medical_history_treatments_history FOREIGN KEY(medical_history_id) REFERENCES medical_histories(id),
  CONSTRAINT fk_medical_history_treatments_treatment FOREIGN KEY(treatment_id) REFERENCES treatments(id)
);
CREATE INDEX idx_medical_history_treatments_history_treatment 
ON medical_history_treatments (medical_history_id, treatment_id);