CREATE DEFINER=`root`@`localhost` PROCEDURE `new_procedure2`()
BEGIN

DROP TABLE IF EXISTS master_table2;
CALL master_table2_import;

INSERT INTO master_table2 (MemberID, ProviderID, Vendor, PCP, Year, Specialty, PlaceSvc, PayDelay, LengthOfStay, DSFS, PrimaryConditionGroup, CharlsonIndex, ProcedureGroup, SupLOS)
SELECT MemberID, ProviderID, Vendor, PCP, Year, Specialty, PlaceSvc, PayDelay, LengthOfStay, DSFS, PrimaryConditionGroup, CharlsonIndex, ProcedureGroup, SupLOS FROM claims_table;

UPDATE master_table2
SET CharlsonIndex = '1-2'
WHERE CharlsonIndex = '2-Jan';

UPDATE master_table2
SET CharlsonIndex = '3-4'
WHERE CharlsonIndex = '4-Mar';

UPDATE master_table2 a
LEFT JOIN daysinhospital_y2 b
ON a.MemberID = b.MemberID
SET a.Y2_ClaimsTruncated = b.Y2_ClaimsTruncated, a.Y2_DaysInHospital = b.Y2_DaysInHospital;

UPDATE master_table2 a
LEFT JOIN daysinhospital_y3_table b
ON a.MemberID = b.MemberID
SET a.Y3_ClaimsTruncated = b.Y3_ClaimsTruncated, a.Y3_DaysInHospital = b.Y3_DaysInHospital;

UPDATE master_table2 a
LEFT JOIN daysinhospital_y4_target_table b
ON a.MemberID = b.MemberID
SET a.Y4_ClaimsTruncated = b.Y4_ClaimsTruncated, a.Y4_DaysInHospital = b.Y4_DaysInHospital;


END
