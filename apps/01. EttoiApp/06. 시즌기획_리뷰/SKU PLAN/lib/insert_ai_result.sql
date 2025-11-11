INSERT INTO ai_sku_plan 
  (br_cd, year_season, category, prompt, result)
VALUES 
  ('07', '{{ select_season.value }}', '{{ var_select_category.value.replace(/'/g, "''") }}', '{{ textArea_prompt.value }}', '{{ get_analysis.data.choices[0].message.content.replace(/'/g, "''") }}')