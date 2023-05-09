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
