using afIoc
using afBedSheet::BedSheetWebMod

internal class TestViewHelpers : EfanTest {
	
	@Inject private EfanTemplates? efan
	
	override Void setup() {
		modules = [EfanModule#, T_Mod01#, BedSheetWebMod#.pod.type("BedSheetModule")]
		super.setup
	}
	
	Void testMultipleViewHelpers() {
		template := "<%= a() %> <%= b %>"
		output	 := efan.renderFromStr(template, null)
		verifyEq("Judge Dredd", output)
	}
}

@NoDoc
mixin T_Vh3 {
	Str a() { "Judge" }
}

@NoDoc
mixin T_Vh4 {
	Str b() { "Dredd" }
}

internal class T_Mod01 {
	@Contribute { serviceType=EfanViewHelpers# }
	static Void contrib(OrderedConfig config) {
		config.add(T_Vh3#)
		config.add(T_Vh4#)
	}
}