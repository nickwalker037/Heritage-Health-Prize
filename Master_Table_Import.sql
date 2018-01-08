CREATE DEFINER=`root`@`localhost` PROCEDURE `master_table2_import`()
BEGIN

	DROP TABLE IF EXISTS master_table2;

	CREATE TABLE master_table2 (
    MemberID VARCHAR(511),
    ProviderID VARCHAR(511),
    Vendor VARCHAR(511),
    PCP VARCHAR(511),
    Year VARCHAR(511),
    Specialty VARCHAR(511),
    PlaceSvc VARCHAR(511),
    PayDelay VARCHAR(511),
    LengthOfStay VARCHAR(511),
    DSFS VARCHAR(511),
    PrimaryConditionGroup VARCHAR(511),
    CharlsonIndex VARCHAR(511),
    ProcedureGroup VARCHAR(511),
    SupLOS VARCHAR(511),
    Y2_ClaimsTruncated VARCHAR(511),
    Y2_DaysInHospital VARCHAR(511),
    Y3_ClaimsTruncated VARCHAR(511),
    Y3_DaysInHospital VARCHAR(511),
    Y4_ClaimsTruncated VARCHAR(511),
    Y4_DaysInHospital VARCHAR(511),
    LabCount VARCHAR(511),
    DrugCount VARCHAR(511),
    AgeAtFirstClaim VARCHAR(511),
    Sex VARCHAR(511)
    );

END
