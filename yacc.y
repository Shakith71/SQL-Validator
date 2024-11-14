%{                                                                                                                                                                      
                                                                                                                                                                        
#include <stdio.h>                                                                                                                                                      
                                                                                                                                                                        
#include<stdlib.h>                                                                                                                                                      
                                                                                                                                                                        
#include<string.h>                                                                                                                                                      
                                                                                                                                                                        
extern FILE *yyin;                                                                                                                                                      
                                                                                                                                                                        
void yyerror (const char *str) {                                                                                                                                        
                                                                                                                                                                        
        fprintf(stderr, "error: %s\n", str);                                                                                                                            
                                                                                                                                                                        
}                                                                                                                                                                       
                                                                                                                                                                        
int yywrap() {                                                                                                                                                          
                                                                                                                                                                        
        return 1;                                                                                                                                                       
                                                                                                                                                                        
}                                                                                                                                                                       
                                                                                                                                                                        
int iden = 0;                                                                                                                                                           
                                                                                                                                                                        
int val = 0;                                                                                                                                                            
                                                                                                                                                                        
int flag = 1;                                                                                                                                                           
                                                                                                                                                                        
%}                                                                                                                                                                      
                                                                                                                                                                        
%token SELECT FROM IDENTIFIER WHERE AND OR LE GE LT GT NUMBER SEMICOLON GROUP BY ORDER DELETE UPDATE SET INSERT INTO VALUES                                             
                                                                                                                                                                        
%token INNER LEFT RIGHT JOIN ON FULL OUTER                                                                                                                              

                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
%left '+' '-'                                                                                                                                                           
                                                                                                                                                                        
%left '*' '/'                                                                                                                                                           
                                                                                                                                                                        
%left AND                                                                                                                                                               
                                                                                                                                                                        
%left OR                                                                                                                                                                
                                                                                                                                                                        
%nonassoc '<' '>' '<=' '>=' '='                                                                                                                                         
                                                                                                                                                                        
%%                                                                                                                                                                      
line: SELECT { printf(" SELECT "); } items                                                                                                                              
      FROM { printf("\nFROM");} table_reference                                                                                                                         
                                                                                                                                                                        
      opt_join opt_on opt_where opt_group_by opt_order_by '\n' { printf("\nSyntax Correct\n"); }                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
    | DELETE {printf("\nDELETE");} opt_table FROM{printf("\nFROM");} table_reference opt_join opt_on opt_where '\n' { printf("\nSyntax Correct\n"); }                   
                                                                                                                                                                        
                                                                                                                                                                        
    | UPDATE {printf("\nUPDATE");} table_reference opt_join opt_on  comp '\n' { printf("\nSyntax Correct\n"); }                                                         

                                                                                                                                                                        

                                                                                                                                                                        
    | INSERT {printf("\nINSERT");} INTO {printf("\nINTO");} IDENTIFIER {printf(" \n\tIDENTIFIER");} next '\n' {                                                         
                                                                                                                                                                        
                        if ( flag == 0 ) {                                                                                                                              
        printf("Error : Number of identifiers doesn't match with the number of values\n");                                                                              
                                                                                                                                                                        
}                                                                                                                                                                       
                                                                                                                                                                        
        else {                                                                                                                                                          
                                                                                                                                                                        
        printf("\nSyntax Correct\n");                                                                                                                                   
                                                                                                                                                                        
                                                                                                                                                                        
}                                                                                                                                                                       
                                                                                                                                                                        
 };                                                                                                                                                                     
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
comp: SET {printf("\nSET");} assign opt_where                                                                                                                           
                                                                                                                                                                        
                                                                                                                                                                        
next: VALUES '('{printf("\nVALUES ( ");} values ')' {printf("\n )");}                                                                                                   
                                                                                                                                                                        
                                                                                                                                                                        
    | '(' {printf("\n(");} insident ')' VALUES '(' {printf("\n) VALUES (");} values ')'   {printf("\n ) ");}                                                            
                                                                                                                                                                        
        { if ( iden != val ) { flag = 0; }                                                                                                                              
                                                                                                                                                                        
        else { flag = 1; }};                                                                                                                                            
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
insident: IDENTIFIER { iden++; } {printf(" \n\tIDENTIFIER");}                                                                                                           
                                                                                                                                                                        
        | IDENTIFIER ','{printf("\n\tIDENTIFIER ,");} insident { iden++; }                                                                                              
                                                                                                                                                                        
values:                                                                                                                                                                 
                                                                                                                                                                        
        IDENTIFIER { val++; } {printf(" \n\tIDENTIFIER");}                                                                                                              
                                                                                                                                                                        
        | NUMBER { val++; } {printf(" \n\tNUMBER");}                                                                                                                    
                                                                                                                                                                        
        | IDENTIFIER ',' {printf("\n\tIDENTIFIER , ");} values { val++; }                                                                                               
                                                                                                                                                                        
        | NUMBER ','{printf("\n\tNUMBER ,"); } values { val++; }                                                                                                        
                                                                                                                                                                        
items: '*' { printf("\n\t*"); } | qualified_identifiers;                                                                                                                

                                                                                                                                                                        
qualified_identifiers: qualified_identifier                                                                                                                             
                                                                                                                                                                        
                     | qualified_identifiers ',' {printf(" , ");}qualified_identifier;                                                                                  
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
qualified_identifier: IDENTIFIER { printf(" \n\tIDENTIFIER ");} '.' {printf(" . ");} IDENTIFIER {printf(" IDENTIFIER ");}                                               
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
                    | IDENTIFIER {printf(" \n\tIDENTIFIER ");} ;                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
opt_table: | table_reference;                                                                                                                                           
                                                                                                                                                                        
table_reference: IDENTIFIER {printf(" \n\tIDENTIFIER ");}                                                                                                               
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
                | IDENTIFIER IDENTIFIER {printf(" \n\tIDENTIFIER IDENTIFIER ");}                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
                | table_reference ',' {printf(",");} again; //for self join                                                                                             
                                                                                                                                                                        
                                                                                                                                                                        
again: IDENTIFIER {printf(" \n\tIDENTIFIER ");} | IDENTIFIER IDENTIFIER {printf(" \n\tIDENTIFIER IDENTIFIER");} ; //for self join                                       
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
identifiers: IDENTIFIER {printf(" \n\t IDENTIFIER ");}| IDENTIFIER ',' {printf(" \n\t IDENTIFIER , ");}                                                                 
                                                                                                                                                                        
                identifiers;                                                                                                                                            
                                                                                                                                                                        
opt_on: | ON {printf(" \n\t ON");} condition;                                                                                                                           
                                                                                                                                                                        
                                                                                                                                                                        
opt_join:                                                                                                                                                               
                                                                                                                                                                        
        | INNER JOIN {printf(" \n INNER JOIN");} table_reference                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
        | LEFT JOIN {printf(" \n LEFT JOIN");} table_reference                                                                                                          
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
        | RIGHT JOIN {printf(" \n RIGHT JOIN");} table_reference                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
        | FULL OUTER JOIN {printf(" \n FULL OUTER JOIN");} table_reference                                                                                              
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
        | JOIN {printf(" \n JOIN");}table_reference;                                                                                                                    
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
opt_where: | WHERE {printf(" \n WHERE ");}condition;                                                                                                                    
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
assign:                                                                                                                                                                 
        IDENTIFIER '=' IDENTIFIER {printf(" \n\tIDENTIFIER = IDENTIFIER");}                                                                                             
        | IDENTIFIER '=' IDENTIFIER '+' NUMBER {printf(" \n\t IDENTIFIER = IDENTIFIER + IDENTIFIER");}                                                                  
        | IDENTIFIER '=' IDENTIFIER '-' NUMBER {printf(" \n\t IDENTIFIER = IDENTIFIER - IDENTIFIER");}                                                                  
        | IDENTIFIER '=' IDENTIFIER '*' NUMBER {printf(" \n\t IDENTIFIER = IDENTIFIER * IDENTIFIER");}                                                                  
        | IDENTIFIER '=' IDENTIFIER '/' NUMBER {printf(" \n\t IDENTIFIER = IDENTIFIER / IDENTIFIER");}                                                                  
        | IDENTIFIER '=' NUMBER {printf(" \n\tIDENTIFIER = NUMBER");}                                                                                                   
        |IDENTIFIER '=' IDENTIFIER {printf(" \n\tIDENTIFIER = IDENTIFIER");}  ','{ printf(",");} assign                                                                 
        | IDENTIFIER '=' IDENTIFIER '-' NUMBER {printf(" \n\t IDENTIFIER = IDENTIFIER - IDENTIFIER");}  ',' {printf(",");} assign                                       
                                                                                                                                                                        
                                                                                                                                                                        
        | IDENTIFIER '=' IDENTIFIER '+' NUMBER  {printf(" \n\t IDENTIFIER = IDENTIFIER + IDENTIFIER");} ',' {printf(",");} assign                                       
                                                                                                                                                                        
                                                                                                                                                                        
        |  IDENTIFIER '=' IDENTIFIER '*' NUMBER{printf(" \n\t IDENTIFIER = IDENTIFIER * IDENTIFIER");} ',' {printf(",");} assign                                        
                                                                                                                                                                        
        | IDENTIFIER '=' IDENTIFIER '/' NUMBER{printf(" \n\t IDENTIFIER = IDENTIFIER / IDENTIFIER");} ',' {printf(",");} assign                                         
                                                                                                                                                                        
                                                                                                                                                                        
        | IDENTIFIER '=' NUMBER {printf(" \n\tIDENTIFIER = NUMBER");} ',' {printf(",");} assign                                                                         
                                                                                                                                                                        
        ;                                                                                                                                                               
                                                                                                                                                                        
                                                                                                                                                                        
condition: IDENTIFIER '=' IDENTIFIER {printf(" \n\t IDENTIFIER '=' IDENTIFIER");}                                                                                       
                                                                                                                                                                        
         | IDENTIFIER '=' NUMBER { printf("\n\t IDENTIFIER '=' NUMBER"); }                                                                                              
                                                                                                                                                                        
                                                                                                                                                                        
         | IDENTIFIER LT NUMBER {printf(" \n\t IDENTIFIER LT NUMBER ");}                                                                                                
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
        | IDENTIFIER GT NUMBER {printf(" \n\t IDENTIFIER GT NUMBER ");}                                                                                                 
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
        | IDENTIFIER LE NUMBER {printf(" \n\t IDENTIFIER LE NUMBER ");}                                                                                                 
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
        | IDENTIFIER GE NUMBER {printf(" \n\t IDENTIFIER GE NUMBER ");}                                                                                                 
                                                                                                                                                                        
                                                                                                                                                                        
        | condition AND condition {printf(" \n\t IDENTIFIER AND NUMBER ");}                                                                                             
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
        | condition OR condition {printf(" \n\t IDENTIFIER OR NUMBER ");}                                                                                               
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
;                                                                                                                                                                       
                                                                                                                                                                        
opt_group_by:                                                                                                                                                           
                                                                                                                                                                        
        | GROUP BY {printf(" \n\t GROUP BY ");} identifiers ;                                                                                                           
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
opt_order_by:                                                                                                                                                           
                                                                                                                                                                        
           | ORDER BY {printf(" \n\t ORDER BY ");}identifiers ;                                                                                                         
                                                                                                                                                                        
                                                                                                                                                                        
%%                                                                                                                                                                      
int main(int argc, char **argv){                                                                                                                                        
                                                                                                                                                                        
if(argc < 2){                                                                                                                                                           
                                                                                                                                                                        
        fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);                                                                                                           
                                                                                                                                                                        
        return 1;                                                                                                                                                       
                                                                                                                                                                        
}                                                                                                                                                                       
                                                                                                                                                                        
yyin = fopen(argv[1], "r");                                                                                                                                             
                                                                                                                                                                        
if(!yyin){                                                                                                                                                              
                                                                                                                                                                        
        perror("Failed to open input file");                                                                                                                            
                                                                                                                                                                        
        return 1;                                                                                                                                                       
                                                                                                                                                                        
}                                                                                                                                                                       
                                                                                                                                                                        
yyparse();                                                                                                                                                              
                                                                                                                                                                        
fclose(yyin);                                                                                                                                                           
                                                                                                                                                                        
return 0;                                                                                                                                                               
                                                                                                                                                                        
}  