 if (exists(SELECT 1 FROM sys.columns WHERE Name = 'FilterActionIdIsRegex'
            					AND Object_ID = Object_ID('LogFilter')))
									print('Wow')
									ELSE
									print('Damn')