USE [CCS_EbankitSecurityCenter]

declare @transactionTable table (transactionId int)
insert into @transactionTable values
	(1100042)

declare @isCommercial bit = 0
declare @AddForMobile bit = 1
declare @transactionId int
begin tran insert_package
declare c_transaction cursor for select * from @transactionTable
	open c_transaction
	fetch next from c_transaction into @transactionId
	while @@fetch_status = 0 begin
		Exec usp_CCS_InsertTransactionToPackage  1, NULL, @isCommercial, @transactionId, @AddForMobile
		Exec usp_CCS_InsertTransactionToPackage  2, NULL, @isCommercial, @transactionId, @AddForMobile
		Exec usp_CCS_InsertTransactionToPackage  3, NULL, @isCommercial, @transactionId, @AddForMobile
	fetch next from c_transaction into @transactionId
	end
	close c_transaction
	deallocate c_transaction
commit tran insert_package