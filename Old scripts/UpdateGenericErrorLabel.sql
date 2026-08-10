update [ResourceLang] SET 
				[Description] = 'Something went wrong', 
				[ModifiedBy] = '2.18.0', 
				[Modified] = GETDATE()
				WHERE [ContentTypeId] =
					(select [contentTypeId] from [Resources] where [Module] = ''
						and [Name] = 'ErrorTitle'
						and [ApplicationId] = 7)