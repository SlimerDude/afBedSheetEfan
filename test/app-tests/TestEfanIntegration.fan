using afIoc
using afEfan
using afBounce
using afBedSheet::BedSheetConfigIds
using afPlastic::PlasticCompiler
using afIocConfig::ApplicationDefaults

internal class TestEfanIntegration : Test {

	BedClient? client
	
	@Inject
	PlasticCompiler? plasticCompiler
	
	override Void setup() {
		server := BedServer(T_AppModule#).addModule(T_EfanMod#).startup
		server.injectIntoFields(this)
		client = server.makeClient
	}

	override Void teardown() {
		client.shutdown
	}	

	Void testWebOkay() {
		res := client.get(`/efanOkay/Beards!`)
		verify(res.asStr.contains("<title>Beards!</title>"))
	}

	Void testErrPageIntegration() {
		client.errOn5xx.enabled = false
		
		res := client.get(`/efanErr`)
		verifyEq(res.statusCode, 500)
		
		Element("h2#efanCompilationErr"   ).verifyTextEq("Efan Compilation Err")
		Element("h2#plasticCompilationErr").verifyTextEq("Plastic Compilation Err")
	}
	
	Void testCompilerHasConfig() {
		verifyEq(plasticCompiler.srcCodePadding, 50)
	}
}

internal class T_EfanMod {
	@Contribute { serviceType=ApplicationDefaults# }
	static Void contributeApplicationDefaults(Configuration config) {
		config[BedSheetConfigIds.srcCodeErrPadding]	= 50
	}	
}