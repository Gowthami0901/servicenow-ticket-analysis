SELECT
    EXTRACT(YEAR FROM created_date) AS year,
    EXTRACT(MONTH FROM created_date) AS month,
    COUNT(*) AS ticket_count,
    AVG(resolution_time_hrs) AS avg_resolution_time,
    COUNT(CASE WHEN status = 'Closed' THEN 1 END) * 1.0 / COUNT(*) AS closure_rate
FROM
    stg_servicenow_tickets
GROUP BY
    year, month