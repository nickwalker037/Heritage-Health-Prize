CREATE DEFINER=`root`@`localhost` PROCEDURE `loop_procedure2`()
BEGIN
    
    DROP TABLE IF EXISTS loop_table2;
    CREATE TABLE loop_table2 (MemberID VARCHAR(511));
    
    INSERT INTO loop_table2 (MemberID) SELECT DISTINCT(MemberID) FROM master_table2;
    
    # Number to add to the end of the column name
    SET @Sp = 0;
    SET @PS = 0;
    SET @PCG = 0;
    SET @PG = 0;
    
    # Statement to execute to add columns to table
    SET @str1 = 'ALTER TABLE loop_table2 ADD ';
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
    
    
    # Populating the rows with values of 0 or 1 based on whether it equals the certain value
	
	SET @Sp = -1;
    SET @PS = -1;
    SET @PCG = -1;
    SET @PG = -1;
    SET @cnt = -1;
    
    
    SET @par1 = '('; # Use these to indicate subqueries
    SET @par2 = ')';
    
    SET @str3 = 'SELECT DISTINCT(Specialty) FROM master_table2 LIMIT ';
    SET @str4 = ',1';
    
    SET @str5 = 'SELECT MemberID FROM loop_table2 LIMIT ';
    SET @str6 = ',1';
    
    SET @str7 = 'SELECT COUNT(';
    SET @str8 = ') FROM master_table2 WHERE MemberID = ';
    SET @str9 = ' AND Specialty = ';
    
    
    SET @str11 = 'UPDATE loop_table2 SET ';
    SET @str12 = ' = ';
    SET @str13 = ' WHERE MemberID = ';
    
    SET @str14 = 'INSERT INTO loop_table2 (';
    SET @str15 = ') ';
    
    
    REPEAT 
		    SET @Sp = @Sp + 1; # We initialize @Sp = -1 so that it iterates through all values of the "Specialty" column
        SET @val = CONCAT(@str3, @Sp, @str4); # Ex. this will give us the value "Surgery"
		    SET @col = CONCAT('Specialty_', @Sp + 1); # This gives us the column corresponding to the value "Surgery", here its "Specialty_1"
        REPEAT 
		        SET @cnt = @cnt + 1; # This will be used to iterate through each distinct "MemberID" column in loop_table2
            SET @memID = CONCAT(@str5, @cnt, @str6); # This will select a distinct "MemberID"
            SET @script = CONCAT(@str7, @par1, @val, @par2, @str8, @par1, @memID, @str9, @par1, @val, @par2); # Return COUNT("Surgery") FROM master_table2 for a specific MemberID
            SET @populate = CONCAT(@str11, @col, @str12, @par1, @script, @par2, @str13, @par1, @memID, @par2);
              PREPARE stmt5 FROM @populate;
              EXECUTE stmt5;	
            SET@TEST = CONCAT(@str14, @col, @str15, @Sp);
              PREPARE stmt5 FROM @TEST;
              EXECUTE stmt5;	
		    UNTIL @cnt > (5) END REPEAT;
    UNTIL @Sp > (@num_Sp - 2) END REPEAT;
    
    
    
END
