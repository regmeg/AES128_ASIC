// CALLBACKGEN_XS
// CALLBACKGEN_GENERATED_BEGIN - GENERATED AUTOMATICALLY by callbackgen
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::attributeCb(VFileLine* fl, const string& text) {
    if (callbackMasterEna() && m_useCb_attribute) {
        cbFileline(fl);
        static string hold1; hold1 = text;
        call(NULL, 1, "attribute", hold1.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::commentCb(VFileLine* fl, const string& text) {
    if (callbackMasterEna() && m_useCb_comment) {
        cbFileline(fl);
        static string hold1; hold1 = text;
        call(NULL, 1, "comment", hold1.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::endparseCb(VFileLine* fl, const string& text) {
    if (callbackMasterEna() && m_useCb_endparse) {
        cbFileline(fl);
        static string hold1; hold1 = text;
        call(NULL, 1, "endparse", hold1.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::keywordCb(VFileLine* fl, const string& text) {
    if (callbackMasterEna() && m_useCb_keyword) {
        cbFileline(fl);
        static string hold1; hold1 = text;
        call(NULL, 1, "keyword", hold1.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::numberCb(VFileLine* fl, const string& text) {
    if (callbackMasterEna() && m_useCb_number) {
        cbFileline(fl);
        static string hold1; hold1 = text;
        call(NULL, 1, "number", hold1.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::operatorCb(VFileLine* fl, const string& text) {
    if (callbackMasterEna() && m_useCb_operator) {
        cbFileline(fl);
        static string hold1; hold1 = text;
        call(NULL, 1, "operator", hold1.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::preprocCb(VFileLine* fl, const string& text) {
    if (callbackMasterEna() && m_useCb_preproc) {
        cbFileline(fl);
        static string hold1; hold1 = text;
        call(NULL, 1, "preproc", hold1.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::stringCb(VFileLine* fl, const string& text) {
    if (callbackMasterEna() && m_useCb_string) {
        cbFileline(fl);
        static string hold1; hold1 = text;
        call(NULL, 1, "string", hold1.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::symbolCb(VFileLine* fl, const string& text) {
    if (callbackMasterEna() && m_useCb_symbol) {
        cbFileline(fl);
        static string hold1; hold1 = text;
        call(NULL, 1, "symbol", hold1.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::sysfuncCb(VFileLine* fl, const string& text) {
    if (callbackMasterEna() && m_useCb_sysfunc) {
        cbFileline(fl);
        static string hold1; hold1 = text;
        call(NULL, 1, "sysfunc", hold1.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::classCb(VFileLine* fl, const string& kwd, const string& name, const string& virt) {
    if (callbackMasterEna() && m_useCb_class) {
        cbFileline(fl);
        static string hold1; hold1 = kwd;
        static string hold2; hold2 = name;
        static string hold3; hold3 = virt;
        call(NULL, 3, "class", hold1.c_str(), hold2.c_str(), hold3.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::contassignCb(VFileLine* fl, const string& kwd, const string& lhs, const string& rhs) {
    if (callbackMasterEna() && m_useCb_contassign) {
        cbFileline(fl);
        static string hold1; hold1 = kwd;
        static string hold2; hold2 = lhs;
        static string hold3; hold3 = rhs;
        call(NULL, 3, "contassign", hold1.c_str(), hold2.c_str(), hold3.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::covergroupCb(VFileLine* fl, const string& kwd, const string& name) {
    if (callbackMasterEna() && m_useCb_covergroup) {
        cbFileline(fl);
        static string hold1; hold1 = kwd;
        static string hold2; hold2 = name;
        call(NULL, 2, "covergroup", hold1.c_str(), hold2.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::defparamCb(VFileLine* fl, const string& kwd, const string& lhs, const string& rhs) {
    if (callbackMasterEna() && m_useCb_defparam) {
        cbFileline(fl);
        static string hold1; hold1 = kwd;
        static string hold2; hold2 = lhs;
        static string hold3; hold3 = rhs;
        call(NULL, 3, "defparam", hold1.c_str(), hold2.c_str(), hold3.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::endcellCb(VFileLine* fl, const string& kwd) {
    if (callbackMasterEna() && m_useCb_endcell) {
        cbFileline(fl);
        static string hold1; hold1 = kwd;
        call(NULL, 1, "endcell", hold1.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::endclassCb(VFileLine* fl, const string& kwd) {
    if (callbackMasterEna() && m_useCb_endclass) {
        cbFileline(fl);
        static string hold1; hold1 = kwd;
        call(NULL, 1, "endclass", hold1.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::endgroupCb(VFileLine* fl, const string& kwd) {
    if (callbackMasterEna() && m_useCb_endgroup) {
        cbFileline(fl);
        static string hold1; hold1 = kwd;
        call(NULL, 1, "endgroup", hold1.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::endinterfaceCb(VFileLine* fl, const string& kwd) {
    if (callbackMasterEna() && m_useCb_endinterface) {
        cbFileline(fl);
        static string hold1; hold1 = kwd;
        call(NULL, 1, "endinterface", hold1.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::endmodportCb(VFileLine* fl, const string& kwd) {
    if (callbackMasterEna() && m_useCb_endmodport) {
        cbFileline(fl);
        static string hold1; hold1 = kwd;
        call(NULL, 1, "endmodport", hold1.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::endmoduleCb(VFileLine* fl, const string& kwd) {
    if (callbackMasterEna() && m_useCb_endmodule) {
        cbFileline(fl);
        static string hold1; hold1 = kwd;
        call(NULL, 1, "endmodule", hold1.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::endpackageCb(VFileLine* fl, const string& kwd) {
    if (callbackMasterEna() && m_useCb_endpackage) {
        cbFileline(fl);
        static string hold1; hold1 = kwd;
        call(NULL, 1, "endpackage", hold1.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::endprogramCb(VFileLine* fl, const string& kwd) {
    if (callbackMasterEna() && m_useCb_endprogram) {
        cbFileline(fl);
        static string hold1; hold1 = kwd;
        call(NULL, 1, "endprogram", hold1.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::endtaskfuncCb(VFileLine* fl, const string& kwd) {
    if (callbackMasterEna() && m_useCb_endtaskfunc) {
        cbFileline(fl);
        static string hold1; hold1 = kwd;
        call(NULL, 1, "endtaskfunc", hold1.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::functionCb(VFileLine* fl, const string& kwd, const string& name, const string& data_type) {
    if (callbackMasterEna() && m_useCb_function) {
        cbFileline(fl);
        static string hold1; hold1 = kwd;
        static string hold2; hold2 = name;
        static string hold3; hold3 = data_type;
        call(NULL, 3, "function", hold1.c_str(), hold2.c_str(), hold3.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::importCb(VFileLine* fl, const string& package, const string& id) {
    if (callbackMasterEna() && m_useCb_import) {
        cbFileline(fl);
        static string hold1; hold1 = package;
        static string hold2; hold2 = id;
        call(NULL, 2, "import", hold1.c_str(), hold2.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::instantCb(VFileLine* fl, const string& mod, const string& cell, const string& range) {
    if (callbackMasterEna() && m_useCb_instant) {
        cbFileline(fl);
        static string hold1; hold1 = mod;
        static string hold2; hold2 = cell;
        static string hold3; hold3 = range;
        call(NULL, 3, "instant", hold1.c_str(), hold2.c_str(), hold3.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::interfaceCb(VFileLine* fl, const string& kwd, const string& name) {
    if (callbackMasterEna() && m_useCb_interface) {
        cbFileline(fl);
        static string hold1; hold1 = kwd;
        static string hold2; hold2 = name;
        call(NULL, 2, "interface", hold1.c_str(), hold2.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::modportCb(VFileLine* fl, const string& kwd, const string& name) {
    if (callbackMasterEna() && m_useCb_modport) {
        cbFileline(fl);
        static string hold1; hold1 = kwd;
        static string hold2; hold2 = name;
        call(NULL, 2, "modport", hold1.c_str(), hold2.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::moduleCb(VFileLine* fl, const string& kwd, const string& name, bool, bool celldefine) {
    if (callbackMasterEna() && m_useCb_module) {
        cbFileline(fl);
        static string hold1; hold1 = kwd;
        static string hold2; hold2 = name;
        static string hold4; hold4 = celldefine ? "1":"0";
        call(NULL, 4, "module", hold1.c_str(), hold2.c_str(), NULL, hold4.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::packageCb(VFileLine* fl, const string& kwd, const string& name) {
    if (callbackMasterEna() && m_useCb_package) {
        cbFileline(fl);
        static string hold1; hold1 = kwd;
        static string hold2; hold2 = name;
        call(NULL, 2, "package", hold1.c_str(), hold2.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::parampinCb(VFileLine* fl, const string& name, const string& conn, int index) {
    if (callbackMasterEna() && m_useCb_parampin) {
        cbFileline(fl);
        static string hold1; hold1 = name;
        static string hold2; hold2 = conn;
        static string hold3; static char num3[30]; sprintf(num3,"%d",index); hold3=num3;
        call(NULL, 3, "parampin", hold1.c_str(), hold2.c_str(), hold3.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::pinCb(VFileLine* fl, const string& name, const string& conn, int index) {
    if (callbackMasterEna() && m_useCb_pin) {
        cbFileline(fl);
        static string hold1; hold1 = name;
        static string hold2; hold2 = conn;
        static string hold3; static char num3[30]; sprintf(num3,"%d",index); hold3=num3;
        call(NULL, 3, "pin", hold1.c_str(), hold2.c_str(), hold3.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::portCb(VFileLine* fl, const string& name, const string& objof, const string& direction, const string& data_type
	, const string& array, int index) {
    if (callbackMasterEna() && m_useCb_port) {
        cbFileline(fl);
        static string hold1; hold1 = name;
        static string hold2; hold2 = objof;
        static string hold3; hold3 = direction;
        static string hold4; hold4 = data_type;
        static string hold5; hold5 = array;
        static string hold6; static char num6[30]; sprintf(num6,"%d",index); hold6=num6;
        call(NULL, 6, "port", hold1.c_str(), hold2.c_str(), hold3.c_str(), hold4.c_str(), hold5.c_str(), hold6.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::programCb(VFileLine* fl, const string& kwd, const string& name) {
    if (callbackMasterEna() && m_useCb_program) {
        cbFileline(fl);
        static string hold1; hold1 = kwd;
        static string hold2; hold2 = name;
        call(NULL, 2, "program", hold1.c_str(), hold2.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::taskCb(VFileLine* fl, const string& kwd, const string& name) {
    if (callbackMasterEna() && m_useCb_task) {
        cbFileline(fl);
        static string hold1; hold1 = kwd;
        static string hold2; hold2 = name;
        call(NULL, 2, "task", hold1.c_str(), hold2.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::varCb(VFileLine* fl, const string& kwd, const string& name, const string& objof, const string& net
	, const string& data_type, const string& array, const string& value) {
    if (callbackMasterEna() && m_useCb_var) {
        cbFileline(fl);
        static string hold1; hold1 = kwd;
        static string hold2; hold2 = name;
        static string hold3; hold3 = objof;
        static string hold4; hold4 = net;
        static string hold5; hold5 = data_type;
        static string hold6; hold6 = array;
        static string hold7; hold7 = value;
        call(NULL, 7, "var", hold1.c_str(), hold2.c_str(), hold3.c_str(), hold4.c_str(), hold5.c_str(), hold6.c_str(), hold7.c_str());
    }
}
// GENERATED AUTOMATICALLY by callbackgen
void VParserXs::useCbEna(const char* name, bool flag) {
    if (0) ;
    else if (0==strcmp(name,"attribute")) m_useCb_attribute = flag;
    else if (0==strcmp(name,"class")) m_useCb_class = flag;
    else if (0==strcmp(name,"comment")) m_useCb_comment = flag;
    else if (0==strcmp(name,"contassign")) m_useCb_contassign = flag;
    else if (0==strcmp(name,"covergroup")) m_useCb_covergroup = flag;
    else if (0==strcmp(name,"defparam")) m_useCb_defparam = flag;
    else if (0==strcmp(name,"endcell")) m_useCb_endcell = flag;
    else if (0==strcmp(name,"endclass")) m_useCb_endclass = flag;
    else if (0==strcmp(name,"endgroup")) m_useCb_endgroup = flag;
    else if (0==strcmp(name,"endinterface")) m_useCb_endinterface = flag;
    else if (0==strcmp(name,"endmodport")) m_useCb_endmodport = flag;
    else if (0==strcmp(name,"endmodule")) m_useCb_endmodule = flag;
    else if (0==strcmp(name,"endpackage")) m_useCb_endpackage = flag;
    else if (0==strcmp(name,"endparse")) m_useCb_endparse = flag;
    else if (0==strcmp(name,"endprogram")) m_useCb_endprogram = flag;
    else if (0==strcmp(name,"endtaskfunc")) m_useCb_endtaskfunc = flag;
    else if (0==strcmp(name,"function")) m_useCb_function = flag;
    else if (0==strcmp(name,"import")) m_useCb_import = flag;
    else if (0==strcmp(name,"instant")) m_useCb_instant = flag;
    else if (0==strcmp(name,"interface")) m_useCb_interface = flag;
    else if (0==strcmp(name,"keyword")) m_useCb_keyword = flag;
    else if (0==strcmp(name,"modport")) m_useCb_modport = flag;
    else if (0==strcmp(name,"module")) m_useCb_module = flag;
    else if (0==strcmp(name,"number")) m_useCb_number = flag;
    else if (0==strcmp(name,"operator")) m_useCb_operator = flag;
    else if (0==strcmp(name,"package")) m_useCb_package = flag;
    else if (0==strcmp(name,"parampin")) m_useCb_parampin = flag;
    else if (0==strcmp(name,"pin")) m_useCb_pin = flag;
    else if (0==strcmp(name,"port")) m_useCb_port = flag;
    else if (0==strcmp(name,"preproc")) m_useCb_preproc = flag;
    else if (0==strcmp(name,"program")) m_useCb_program = flag;
    else if (0==strcmp(name,"string")) m_useCb_string = flag;
    else if (0==strcmp(name,"symbol")) m_useCb_symbol = flag;
    else if (0==strcmp(name,"sysfunc")) m_useCb_sysfunc = flag;
    else if (0==strcmp(name,"task")) m_useCb_task = flag;
    else if (0==strcmp(name,"var")) m_useCb_var = flag;
}
// CALLBACKGEN_GENERATED_END - GENERATED AUTOMATICALLY by callbackgen
