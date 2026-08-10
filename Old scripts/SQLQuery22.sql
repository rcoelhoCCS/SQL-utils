use CCS_EbankitMPS
declare @resources table(_module nvarchar(50), _name nvarchar(100), _desc nvarchar(max))

insert into @resources values
('FHSAContent','EducationalTitle','About FHSAs'),
('FHSAContent','TitleGIC','What is an FHSA?'),
('FHSAContent','DescriptionGIC','A First Home Savings Account (FHSA) is a registered account introduced by the Government of Canada that helps you save tax-free for the purchase of your first home.'),
('FHSAContent','ShowGIC','FHSA benefits'),
('FHSAContent','TitleMutual','Building and using your FHSA'),
('FHSAContent','DescriptionMutual','An FHSA can be made up of different types of investments, and is subject to contribution limits and rules.'),
('FHSAContent','ShowMutual','More information'),
('ContractOpening','FHAI_PageTitle','Open an FHSA'),
('ContractOpening','FHAI_PageDescription','A First Home Savings Account (FHSA) helps you save tax-free for your first home.'),
('FHSAContent','FirstTitle','Save on taxes with deductible contributions '),
('FHSAContent','FirstDescription','Contributions you make are subtracted from your taxable income, potentially lowering the amount of taxes you pay'),
('FHSAContent','SecondTitle','Grow your savings and investments tax-free'),
('FHSAContent','SecondDescription','Earnings you make in the account are not taxed as income, helping you reach your home ownership goals quicker.'),
('FHSAContent','ThirdTitle','Withdraw funds tax-free'),
('FHSAContent','ThirdDescription','FHSA withdrawals are not taxed when you withdraw them for a qualifying home purchase. That means more of your savings can go towards your goals.'),
('FHSAContent','MoreFirstTitle','Contribution limits'),
('FHSAContent','MoreFirstDescription','With an FHSA, you can make tax deductible contributions of up to $8,000 annually, to a lifetime maximum of $40,000. If you don''t contribute the full $8,000 in a single year, the balance can be carried forward and added to a future year''s contribution limit.'),
('FHSAContent','MoreSecondTitle','Investments that can be held in an FHSA'),
('FHSAContent','MoreSecondDescription','Think of an FHSA like a bucket, that can hold a combination of savings and investments. This may include savings accounts, Guaranteed Investment Certificates (GICs), stocks and bonds, and mutual funds. Whichever combination you choose, together they make up your FHSA and your contribution room is shared across it.'),
('FHSAContent','MoreThirdTitle','Deadlines for using funds'),
('FHSAContent','MoreThirdDescription','The funds in your FHSA must be used by December 31 of the 15th year after opening the account, or by December 31 of the year you turn 71 (whichever comes first). If you haven''t used the funds by then, you have some options.'),
('TRXC1804796','FHAI','Open an FHSA'),
('OPENACCOUNTFHAI','TitleText','Contact us to open your first FHSA'),
('OPENACCOUNTFHAI','ButtonText','Book an appointment'),
('TRXC0182', 'ShowMemberships', 'Show memberships'),
('TRXC0182', 'HideMemberships', 'Hide memberships'),
('JS', 'pendingTransactionsReview', 'Pending transactions'),
('JS', 'eTransfersReview', 'Pending eTransfer or CRA transactions'),
('OPENCONTRACT', 'CallUs', 'or call us at 1.888.517.7000'),
('OPENCONTRACTRRSP', 'BenefitsTitle', 'RRSP benefits'),
('OPENCONTRACTTFSA', 'BenefitsTitle', 'TFSA benefits'),
('OPENCONTRACTFHSA', 'BenefitsTitle', 'FHSA benefits'),
('OPENCONTRACTRRSP', 'EducationalTitle', 'More about RRSPs'),
('OPENCONTRACTTFSA', 'EducationalTitle', 'More about TFSAs'),
('OPENCONTRACTFHSA', 'EducationalTitle', 'More about FHSAs'),
('OPENCONTRACTRRSP','TitleText','Start with an RRSP High-Interest Savings Account'),
('OPENCONTRACTTFSA','TitleText','Start with a TFSA High-Interest Savings Account'),
('OPENCONTRACTFHSA','TitleText','Contact us to open your first FHSA'),
('OPENCONTRACTFHSA','ButtonText','Book an appointment'),
('TRXC1802796', 'FHAI', 'Open an FHSA'),
('Transaction_1000181', 'Title', 'Open an FHSA account'),
('ContractOpening','RSPI_RSPV_PageDescription', 'A Registered Retirement Savings Plan (RRSP) helps you save tax-free for retirement.'),
('ContractOpening','TFAI_TFAV_PageDescription','A Tax-Free Savings Account (TFSA) helps you build your savings, tax-free.'),
('MessageType','999','General'),
('MessageType','998','General'),
('JS', 'onceEveryErrorD', '#MIN#-99'),
('JS', 'DailyError', 'Transfer frequency must be #MIN# days or more. Select a different transfer frequency')

declare @applicationId SMALLINT = 7;
DECLARE @contentTypeId BIGINT;
declare @isGeneric BIT = 0;
declare @createdBy VARCHAR(50) = '2.16.0';
declare @updatedBy VARCHAR(50) = '2.16.0';
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
				
					insert into [Resources]  (ApplicationId, Generic, [Name], [Module], CreatedBy, Created, ModifiedBy, Modified, ContentTypeId) 
					values (@applicationId, @isGeneric, @name, @module, @createdBy, @now, @updatedBy, @now, @contentTypeId);
				

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