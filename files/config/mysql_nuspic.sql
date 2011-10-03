CREATE DATABASE nuspic_default;
CREATE DATABASE nuspic_networks;
CREATE DATABASE nuspic_simulations;

GRANT ALL ON nuspic_default.* TO nuspic@localhost IDENTIFIED BY 'nuspic';
GRANT ALL ON nuspic_networks.* TO nuspic@localhost IDENTIFIED BY 'nuspic';
GRANT ALL ON nuspic_simulations.* TO nuspic@localhost IDENTIFIED BY 'nuspic';
