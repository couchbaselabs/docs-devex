cbq> SELECT CASE 
      WHEN  GetBusinessDays('02/14/2025', '4/16/2025') > 44 THEN "true" 
      ELSE "false" 
      END 
      AS response;