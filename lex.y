%{                                                                                                                                                                      
#include <stdio.h>                                                                                                                                                      
                                                                                                                                                                        
#include "y.tab.h"                                                                                                                                                      
                                                                                                                                                                        
extern int yylval;                                                                                                                                                      
                                                                                                                                                                        
%}                                                                                                                                                                      
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
%%                                                                                                                                                                      
                                                                                                                                                                        
select                                  return SELECT;                                                                                                                  
SELECT                                  return SELECT;                                                                                                                  
delete                                  return DELETE;                                                                                                                  
DELETE                                  return DELETE;                                                                                                                  
update                                  return UPDATE;                                                                                                                  
UPDATE                                  return UPDATE;                                                                                                                  
set                                     return SET;                                                                                                                     
SET                                     return SET;                                                                                                                     
from                                    return FROM;                                                                                                                    
FROM                                    return FROM;                                                                                                                    
insert                                  return INSERT;                                                                                                                  
INSERT                                  return INSERT;                                                                                                                  
into                                    return INTO;                                                                                                                    
INTO                                    return INTO;                                                                                                                    
values                                  return VALUES;                                                                                                                  
VALUES                                  return VALUES;                                                                                                                  
where                                   return WHERE;                                                                                                                   
WHERE                                   return WHERE;                                                                                                                   
                                                                                                                                                                        
and                                             return AND;                                                                                                             
AND                                             return AND;                                                                                                             
or                                              return OR;                                                                                                              
OR                                              return OR;                                                                                                              
group                                           return GROUP;                                                                                                           
GROUP                                           return GROUP;                                                                                                           
order                                           return ORDER;                                                                                                           
ORDER                                           return ORDER;                                                                                                           
by                                              return BY;                                                                                                              
BY                                              return BY;                                                                                                              
inner                                           return INNER;                                                                                                           
INNER                                           return INNER;                                                                                                           
left                                            return LEFT;                                                                                                            
LEFT                                            return LEFT;                                                                                                            
right                                           return RIGHT;                                                                                                           
RIGHT                                           return RIGHT;                                                                                                           
join                                            return JOIN;                                                                                                            
JOIN                                            return JOIN;                                                                                                            
on                                              return ON;                                                                                                              
ON                                              return ON;                                                                                                              
full                                            return FULL;                                                                                                            
FULL                                            return FULL;                                                                                                            
outer                                           return OUTER;                                                                                                           
OUTER                                           return OUTER;                                                                                                           
                                                                                                                                                                        
[.]                                             return '.';                                                                                                             
[']                                             return *yytext;                                                                                                         
[*]                                             return *yytext;                                                                                                         
[+]                                             return *yytext;                                                                                                         
[-]                                             return *yytext;                                                                                                         
[/]                                             return *yytext;                                                                                                         
[,]                                             return *yytext;                                                                                                         
[(]                                             return *yytext;                                                                                                         
[)]                                             return *yytext;                                                                                                         
[=]                                             return *yytext;                                                                                                         
[<=]    { return LE; }                                                                                                                                                  
[>=]    { return GE; }                                                                                                                                                  
'<'     { return LT; }                                                                                                                                                  
'>'     { return GT; }                                                                                                                                                  
';'     { return SEMICOLON; }                                                                                                                                           
[a-zA-Z][.a-zA-Z0-9_]*  return IDENTIFIER;                                                                                                                              
'([a-zA-Z0-9_.]+)' return IDENTIFIER;                                                                                                                                   
[0-9]+  { yylval = atoi(yytext); return NUMBER; }                                                                                                                       
\n                                              return *yytext;                                                                                                         
                                                                                                                                                                        
[ \t]+                                  /* ignore whitespace */;                                                                                                        
. { return yytext[0]; }                                                                                                                                                 
%%     