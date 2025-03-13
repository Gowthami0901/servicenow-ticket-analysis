WITH cleaned_data AS (
    SELECT
        ticket_id,
        category,
        sub_category,
        priority,
        created_date::timestamp AS created_date,
        resolved_date::timestamp AS resolved_date,
        status,
        assigned_group,
        technician,
        resolution_time_hrs,
        customer_impact
    FROM
        servicenow_tickets
    WHERE
        ticket_id IS NOT NULL
)
SELECT * FROM cleaned_data