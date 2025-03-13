SELECT
    ticket_id,
    EXTRACT(YEAR FROM created_date) AS year,
    EXTRACT(MONTH FROM created_date) AS month,
    EXTRACT(DAY FROM created_date) AS day
FROM
    stg_servicenow_tickets