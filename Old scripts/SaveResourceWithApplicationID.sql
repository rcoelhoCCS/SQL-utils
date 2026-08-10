use CCS_EbankitMPS
declare @resources table(_module nvarchar(50), _name nvarchar(100), _desc nvarchar(max), _applicationId SMALLINT)

insert into @resources values
	('VALIDATION', '1252060442', 'Nickname exceeds maximum length', 7),
	('VALIDATION', '1252060442', 'Nickname exceeds maximum length', 77),
	('VALIDATION', '1252060442', 'Nickname exceeds maximum length', 55),
	('VALIDATION', '1252060442', 'Nickname exceeds maximum length', 56)
DECLARE @contentTypeId BIGINT;
declare @isGeneric BIT = 0;
declare @createdBy VARCHAR(50) = '2.4.0';
declare @updatedBy VARCHAR(50) = '2.4.0';
declare @now DATETIME = GETDATE();
declare @lang BIGINT = 2;

declare @module varchar(500);
declare @name varchar(500);
declare @desc varchar(500);
declare @applicationId SMALLINT;

begin tran insert_resources

declare c_resources cursor for select * from @resources
	open c_resources

	fetch next from c_resources into @module, @name, @desc, @applicationId

	while @@fetch_status = 0 begin
		if (@module = 'Generic')
		begin
			set @isGeneric = 1
		end
		else
		begin
			set @isGeneric = 0
		end
		
		set @contentTypeId = (select [contentTypeId] 
								from [Resources] 
							   where [Module] = @module 
								 and [Name] = @name 
								 and [ApplicationId] = @applicationId)
		
		if (@contentTypeId is null)
			begin
				select @contentTypeId = (max([contentType]) + 1) from [ContentType];

				insert into [ContentType] VALUES (@contentTypeId, '', @createdBy, @now, @updatedBy, @now);
				insert into [Resources] values (@applicationId, @isGeneric, @name, @module, @createdBy, @now, @updatedBy, @now, @contentTypeId);
				insert into [ResourceLang] values (@lang, @desc, @createdBy, @now, @updatedBy, @now, @contentTypeId);
			end
		else
			update [ResourceLang] SET 
				[Description] = @desc, 
				[ModifiedBy] = @updatedBy, 
				[Modified] = @now
			WHERE [ContentTypeId] = @contentTypeId AND [idCulture] = @lang

	fetch next from c_resources into @module, @name, @desc, @applicationId
	end

	close c_resources
	deallocate c_resources

commit tran insert_resources