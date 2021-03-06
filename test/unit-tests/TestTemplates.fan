using afIoc::Inject
using afEfan::EfanCompilationErr 

internal class TestTemplates : EfanTest {

	@Inject private EfanTemplates? efan
	
	Void testWarningIfCtxChanges() {
		// okay, so I can't 'test' the warning, but I can test stuff doesn't break
		
		file := `test/unit-tests/hohoho.efan`.toFile
		output   := efan.renderFromFile(file, T_Val2() { it.val = 3 } )
		verifyEq("Ho! Ho! Ho! Merry Christmas!", output)

		// now force a recompile with a more specific ctx
		output   = efan.renderFromFile(file, T_Val1() { it.val = 2 } )
		verifyEq("Ho! Ho! Merry Christmas!", output)
	}

	Void testPlagueScanFile() {	// testing can find double numbers, like 17
		file := `test/unit-tests/plagueScan.efan`.toFile		
		try {
			output := efan.renderFromFile(file, T_Val2() { it.val = 3 } )
			fail
		} catch (EfanCompilationErr err) {
			verifyEq(err.errLineNo, 17)
		}
	}
}

@NoDoc
class T_Val1 {
	virtual Int val
}

@NoDoc
class T_Val2 : T_Val1 {
	override Int val
}