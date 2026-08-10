use CCS_EbankitMPS
declare @resources table(_module nvarchar(50), _name nvarchar(100), _desc nvarchar(max))

insert into @resources values
    /* DBP-596 */
    ('WhatsNewTour_WS','TERMSANDCONDITIONS_Yes','Display Worldsource accounts'),	
	/* DBP-5312 */
	('Breadcrumbs','ProgressBar','Progress bar'),
	/* DBP-6501 */
	('TRXC1805', 'AgreeLabel', 'Agree'),
	('TRXC1805', 'DisagreeLabel', 'Disagree'),
	('TRXC1805', 'ReadTerms', 'You must read all the terms and conditions to continue'),
	('TRXC1806', 'AgreeLabel', 'Agree'),
	('TRXC1806', 'DisagreeLabel', 'Disagree'),
	('TRXC1806', 'ReadTerms', 'You must read all the terms and conditions to continue'),
	/* DBP-8232 */
	('Breadcrumbs','ProgressBarInput','Input current Review not completed Complete not completed'),
	('Breadcrumbs','ProgressBarReview','Input completed Review current Complete not completed'),
	('Breadcrumbs','ProgressBarComplete','Input completed Review completed Complete current'),
	('Breadcrumbs','ProgressBarNewLogin','New Login current Contact info not completed Confirm not completed Done not completed'),
	('Breadcrumbs','ProgressBarContactInfo','New Login completed Contact Info current Confirm not completed Done not completed'),
	('Breadcrumbs','ProgressBarConfirm','New Login completed Contact Info completed Confirm current Done not completed'),
	('Breadcrumbs','ProgressBarDone','New Login completed Contact Info completed Confirm completed Done current')
declare @applicationId SMALLINT = 7;
DECLARE @contentTypeId BIGINT;
declare @isGeneric BIT = 0;
declare @createdBy VARCHAR(50) = '2.9.0';
declare @updatedBy VARCHAR(50) = '2.9.0';
declare @now DATETIME = GETDATE();
declare @lang BIGINT = 2;

declare @module varchar(500);
declare @name varchar(500);
declare @desc varchar(500);

begin tran insert_resources

declare c_resources cursor for select * from @resources
	open c_resources

	fetch next from c_resources into @module, @name, @desc

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

	fetch next from c_resources into @module, @name, @desc
	end

	close c_resources
	deallocate c_resources

commit tran insert_resources