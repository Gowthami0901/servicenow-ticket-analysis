SELECT
    category,
    priority,
    AVG(resolution_time_hrs) AS avg_resolution_time
FROM
    stg_servicenow_tickets
GROUP BY
    category, priority