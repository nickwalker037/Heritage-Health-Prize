CREATE DEFINER=`root`@`localhost` PROCEDURE `Final_Loop_1`()
BEGIN    
    DROP TABLE IF EXISTS Final_Table_1;
    CREATE TABLE Final_Table_1 (MemberID VARCHAR(511),
                                gender_M VARCHAR(511),
                                gender_F VARCHAR(511),
				num_provID VARCHAR(511),
                                num_Vendor VARCHAR(511),
                                num_PCP VARCHAR(511),
                                
                                min_CharlsonIndex VARCHAR(511),
                                max_CharlsonIndex VARCHAR(511),
                                mean_CharlsonIndex VARCHAR(511),
                                range_CharlsonIndex VARCHAR(511),
                                std_CharlsonIndex VARCHAR(511), 
                                
                                min_PayDelay VARCHAR(511),
                                max_PayDelay VARCHAR(511),
                                mean_PayDelay VARCHAR(511),
                                range_PayDelay VARCHAR(511),
                                std_PayDelay VARCHAR(511),
                                
                                min_DSFS VARCHAR(511),
                                max_DSFS VARCHAR(511),
                                mean_DSFS VARCHAR(511),
                                range_DSFS VARCHAR(511),
                                std_DSFS VARCHAR(511)
                                
                                );
    
    INSERT INTO Final_Table_1 (MemberID) SELECT DISTINCT(MemberID) FROM master_table2;
    
    # Number to add to the end of the column name
    SET @Sp = 0;
    SET @PS = 0;
    SET @PCG = 0;
    SET @PG = 0;
    
    # Statement to execute to add columns to table
    SET @str1 = 'ALTER TABLE Final_Table_1 ADD ';
    SET @str2 = ' VARCHAR(100)';
    
    # Number of distinct values in order to find the number of rows you need you add
    SET @num_Sp = (SELECT COUNT(DISTINCT(Specialty)) FROM master_table2);
    SET @num_PS = (SELECT COUNT(DISTINCT(PlaceSvc)) FROM master_table2);
    SET @num_PCG = (SELECT COUNT(DISTINCT(PrimaryConditionGroup)) FROM master_table2);
    SET @num_PG = (SELECT COUNT(DISTINCT(ProcedureGroup)) FROM master_table2);
    SET @num_MemID = (SELECT COUNT(DISTINCT(MemberID)) FROM master_table2);
    
    # Repeat statement used to generate columns with column names Specialty_1 through Specialty_? 
    REPEAT
		SET @Sp = @Sp + 1; 
        SET @str = CONCAT(@str1,'Specialty_',@Sp, @str2);
        PREPARE stmt1 FROM @str;
        EXECUTE stmt1;
	UNTIL @Sp > (@num_Sp - 1) END REPEAT;
    
    # Repeat statement used to generate columns with column names PlaceSvc_1 through PlaceSvc_? 
	REPEAT
		SET @PS = @PS + 1;
        SET @str = CONCAT(@str1,'PlaceSvc_',@PS, @str2);
        PREPARE stmt1 FROM @str;
        EXECUTE stmt1;
	UNTIL @PS > (@num_PS - 1) END REPEAT;
    
    # Repeat statement used to generate columns with column names PCG_1 through PCG_? 
	REPEAT
		SET @PCG = @PCG + 1;
        SET @str = CONCAT(@str1,'PCG_',@PCG, @str2);
        PREPARE stmt1 FROM @str;
        EXECUTE stmt1;
	UNTIL @PCG > (@num_PCG - 1) END REPEAT;
    
    # Repeat statement used to generate columns with column names PG_1 through PG_? 
	REPEAT
		SET @PG = @PG + 1;
        SET @str = CONCAT(@str1,'PG_',@PG, @str2);
        PREPARE stmt1 FROM @str;
        EXECUTE stmt1;
	UNTIL @PG > (@num_PG - 1) END REPEAT;
    
    
    
    
    

#     <----- Populating Specialty, PlaceSvc, PrimaryConditionGroup, and ProcedureGroup columns
    
##### ----------------------------------------------------------------------------- ##### 
##### ----------------------------- Specialty Columns ----------------------------- ##### 
##### ----------------------------------------------------------------------------- #####  
    # Populating the rows with values of 0 or 1 based on whether it equals the certain value
	
	SET @Sp = -1; # We initialize @Sp = -1 so that it iterates through all values of the "Specialty" column
    SET @PS = -1;
    SET @PCG = -1;
    SET @PG = -1;
    SET @cnt = -1;
    
    
    SET @par1 = '('; # Use these to indicate subqueries
    SET @par2 = ')';
    
    SET @str3 = 'SELECT DISTINCT(';
    SET @str3a = ') FROM master_table2 LIMIT ';
    SET @str4 = ',1';
    
    SET @str5 = 'SELECT DISTINCT(MemberID) FROM master_table2 LIMIT ';
    SET @str6 = ',1';
    
    SET @str7 = 'SELECT COUNT(';
    SET @str8 = ') FROM master_table2 WHERE MemberID = ';
    SET @str9 = ' AND ';
    SET @str10 = ' = ';
    
    
    SET @str11 = 'UPDATE Final_Table_1 SET ';
    SET @str12 = ' = ';
    SET @str13 = ' WHERE MemberID = ';
    
    
    
    loop_1: LOOP 
		IF @Sp > (@num_Sp - 2) 
			THEN LEAVE loop_1;
        END IF;
    
		SET @Specialty = 'Specialty';
		SET @Sp = @Sp + 1; 
        SET @Col = 'Specialty_'; # This gives us the column corresponding to the value "Surgery", here its "Specialty_1"
        SET @ColumnName = CONCAT(@Col, @Sp + 1); # This gives us the column corresponding to the value "Surgery", here its "Specialty_1"
        SET @val = CONCAT(@str3, @Specialty, @str3a, @Sp, @str4); # Ex. this will give us the value "Surgery" for "Specialty_1"
        SET @cnt = -1;
        
        loop_2: LOOP
			IF @cnt > (3) 
				THEN LEAVE loop_2;
            END IF;
        
			SET @cnt = @cnt + 1; # This will be used to iterate through each distinct "MemberID" column in Final_Table_1
            
			SET @MemID = CONCAT(@str5, @cnt, @str6); # This will select a distinct "MemberID"
            SET @script = CONCAT(@str7, @par1, @val, @par2, @str8, @par1, @par1, @memID, @par2, @par2, @str9, @Specialty, @str10, @par1, @val, @par2); # Return COUNT("Surgery") FROM master_table2 for a specific MemberID
            SET @TEST = CONCAT(@str11, @ColumnName, @str12, @par1, @script, @par2, @str13, @par1, @MemID, @par2);
				PREPARE stmt5 FROM @TEST;
				EXECUTE stmt5;
		ITERATE loop_2;
		END LOOP;
        
	ITERATE loop_1;
    END LOOP;
	
    
##### ----------------------------------------------------------------------------- ##### 
##### ----------------------------- PlaceSvc Columns ------------------------------ ##### 
##### ----------------------------------------------------------------------------- ##### 
    # This code follows the same format as the "Specialty" columns for the "PlaceSvc" columns
loop_1: LOOP 
		IF @PS > (@num_PS - 2) 
			THEN LEAVE loop_1;
        END IF;
    
		SET @PlaceSvc = 'PlaceSvc';
		SET @PS = @PS + 1; 
        SET @Col = 'PlaceSvc_';
        SET @ColumnName = CONCAT(@Col, @PS + 1); 
        SET @val = CONCAT(@str3, @PlaceSvc, @str3a, @PS, @str4); 
        SET @cnt = -1;
        
        loop_2: LOOP
			IF @cnt > (3) 
				THEN LEAVE loop_2;
            END IF;
        
			SET @cnt = @cnt + 1; 
            
			SET @MemID = CONCAT(@str5, @cnt, @str6); 
            SET @script = CONCAT(@str7, @par1, @val, @par2, @str8, @par1, @par1, @memID, @par2, @par2, @str9, @PlaceSvc, @str10, @par1, @val, @par2);
            SET @TEST = CONCAT(@str11, @ColumnName, @str12, @par1, @script, @par2, @str13, @par1, @MemID, @par2);
				PREPARE stmt5 FROM @TEST;
				EXECUTE stmt5;
		ITERATE loop_2;
		END LOOP;
        
	ITERATE loop_1;
    END LOOP;    
    

##### ----------------------------------------------------------------------------- ##### 
##### -------------------- PrimaryConditionGroup (PCG) Columns -------------------- ##### 
##### ----------------------------------------------------------------------------- ##### 
    # This code follows the same format as the "Specialty" columns for the "PrimaryConditionGroup" columns
loop_1: LOOP 
		IF @PCG > (@num_PCG - 2) 
			THEN LEAVE loop_1;
        END IF;
    
		SET @PrimCG = 'PrimaryConditionGroup';
		SET @PCG = @PCG + 1; 
        SET @Col = 'PCG_'; 
        SET @ColumnName = CONCAT(@Col, @PCG + 1);
        SET @val = CONCAT(@str3, @PrimCG, @str3a, @PCG, @str4); 
        SET @cnt = -1;
        
        loop_2: LOOP
			IF @cnt > (3) 
				THEN LEAVE loop_2;
            END IF;
        
			SET @cnt = @cnt + 1; 
            
			SET @MemID = CONCAT(@str5, @cnt, @str6);
            SET @script = CONCAT(@str7, @par1, @val, @par2, @str8, @par1, @par1, @memID, @par2, @par2, @str9, @PrimCG, @str10, @par1, @val, @par2); 
            SET @TEST = CONCAT(@str11, @ColumnName, @str12, @par1, @script, @par2, @str13, @par1, @MemID, @par2);
				PREPARE stmt5 FROM @TEST;
				EXECUTE stmt5;
		ITERATE loop_2;
		END LOOP;
        
	ITERATE loop_1;
    END LOOP;    
    

##### ----------------------------------------------------------------------------- ##### 
##### ------------------------ ProcedureGroup (PG) Columns ------------------------ ##### 
##### ----------------------------------------------------------------------------- ##### 
    # This code follows the same format as the "Specialty" columns for the "ProcedureGroup" columns
loop_1: LOOP 
		IF @PG > (@num_PG - 2) 
			THEN LEAVE loop_1;
        END IF;
    
		SET @ProcG = 'ProcedureGroup';
		SET @PG = @PG + 1; 
        SET @Col = 'PG_'; 
        SET @ColumnName = CONCAT(@Col, @PG + 1); 
        SET @val = CONCAT(@str3, @ProcG, @str3a, @PG, @str4);
        SET @cnt = -1;
        
        loop_2: LOOP
			IF @cnt > (3) 
				THEN LEAVE loop_2;
            END IF;
        
			SET @cnt = @cnt + 1; 
            
			SET @MemID = CONCAT(@str5, @cnt, @str6);
            SET @script = CONCAT(@str7, @par1, @val, @par2, @str8, @par1, @par1, @memID, @par2, @par2, @str9, @ProcG, @str10, @par1, @val, @par2);
            SET @TEST = CONCAT(@str11, @ColumnName, @str12, @par1, @script, @par2, @str13, @par1, @MemID, @par2);
				PREPARE stmt5 FROM @TEST;
				EXECUTE stmt5;
		ITERATE loop_2;
		END LOOP;
        
	ITERATE loop_1;
    END LOOP;  

   
	
    
	SET @par1 = '('; # Use these to indicate subqueries
    SET @par2 = ')';
    
	SET @str5 = 'SELECT DISTINCT(MemberID) FROM master_table2 LIMIT ';
    SET @str6 = ',1)';
    
	SET @cnt_provID = -1;
	loop_3: LOOP
		IF @cnt_provID > (5)
			THEN LEAVE loop_3;
		END IF;
		
		SET @cnt_provID = @cnt_provID + 1;
        SET @MemID = CONCAT(@str5, @cnt_provID, @str6);
        SET @get_cnt_provID = CONCAT('SELECT COUNT(DISTINCT(ProviderID)) FROM master_table2 WHERE MemberID = (', @MemID, ')');
        SET @upd_tbl = CONCAT('UPDATE Final_Table_1 SET num_provID = ', @par1, @get_cnt_provID, ' WHERE MemberID = (', @MemID);
        PREPARE stmt1 FROM @upd_tbl;
        EXECUTE stmt1;
	ITERATE loop_3;
    END LOOP;



	SET @cnt_Vendor = -1;
	loop_4: LOOP
		IF @cnt_Vendor > (5)
			THEN LEAVE loop_4;
		END IF;
		
		SET @cnt_Vendor = @cnt_Vendor + 1;
        SET @MemID = CONCAT(@str5, @cnt_Vendor, @str6);
        SET @get_cnt_Vendor = CONCAT('SELECT COUNT(DISTINCT(Vendor)) FROM master_table2 WHERE MemberID = (', @MemID, ')');
        SET @upd_tbl = CONCAT('UPDATE Final_Table_1 SET num_Vendor = ', @par1, @get_cnt_Vendor, ' WHERE MemberID = (', @MemID);
        PREPARE stmt1 FROM @upd_tbl;
        EXECUTE stmt1;
	ITERATE loop_4;
    END LOOP;

	SET @cnt_PCP = -1;
	loop_5: LOOP
		IF @cnt_PCP > (5)
			THEN LEAVE loop_5;
		END IF;
		
		SET @cnt_PCP = @cnt_PCP + 1;
        SET @MemID = CONCAT(@str5, @cnt_PCP, @str6);
        SET @get_cnt_PCP = CONCAT('SELECT COUNT(DISTINCT(PCP)) FROM master_table2 WHERE MemberID = (', @MemID, ')');
        SET @upd_tbl = CONCAT('UPDATE Final_Table_1 SET num_PCP = ', @par1, @get_cnt_PCP, ' WHERE MemberID = (', @MemID);
        PREPARE stmt1 FROM @upd_tbl;
        EXECUTE stmt1;
	ITERATE loop_5;
    END LOOP;















/*
Need to do: 
	- labs_table:
		- DSFS
		- LabCount
    - members_table:
		- AgeAtFirstClaim
        - Gender
	- rx_table:
		- Year
        - DSFS
        - DrugCount - need total sum of these per memberID
	- claims_table
		- ProviderID # 7,970 Distinct Vendors, so too many to make individual columns for. We'll use the count of Vendors per MemberID
        - Vendor # 3,966 Distinct Vendors, so too many to make individual columns for. We'll use the count of Vendors per MemberID
        - PCP # 1,183 Distinct PCP's, so too many to make individual columns for. We'll use the count of PCP's per MemberID
        - 
        
 Simple Join:
	- claims_table
		- Year
        - Length 
    




*/







END
