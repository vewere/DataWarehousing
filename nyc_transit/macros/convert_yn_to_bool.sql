-- macro for converting a VARCHAR column with Yes/No values into a boolean column
{% macro convert_yn_to_bool(col) %}
    CASE 
        WHEN {{ col }} = 'Y' THEN true -- convert yes to true
        WHEN {{ col }} = 'N' THEN false -- convert no to false
        ELSE null -- anything else should be null
    END 
{% endmacro %}