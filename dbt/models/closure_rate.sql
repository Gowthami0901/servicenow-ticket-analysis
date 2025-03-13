SELECT
    assigned_group,
    COUNT(CASE WHEN status = 'Closed' THEN 1 END) * 1.0 / COUNT(*) AS closure_rate
FROM
    stg_servicenow_tickets
GROUP BY
    assigned_group