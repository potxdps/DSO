 scribe.fields4History=[
    ["PAComments","PA Comments"],
    ["femaCheckboxV2","Infrastructure PDAs have been completed and Numbers have been vetted between PA and FEMA"],
    ["IAComments","IA Comments"],
    ["femaCheckboxV1","Housing PDAs have been completed and Numbers have been vetted between IA and FEMA"],
    ["otherAttachment","Other Attachment"],
    ["letterAttachment","Letter Attachment"],
    ["decAttachment","Dec Attachment"],
    ["paPDAComplete","Date PA PDA Complete"],
    ["paPDAScheduled","Date PA PDA Scheduled"],
    ["iaPDAComplete","Date IA PDA Complete"],
    ["iaPDAScheduled","Date IA PDA Scheduled"],
    ["iaInitialContactDate","Date of PDA Initial Contact"], 
    ["ack2","ACK Letter Sent 2"],
    ["impactedCountiesDSO","Date DSO Rec'd"],
    ["dsoYesNo","DSO"],
    ["assistanceRequestedDate","Date Asst Requested"],
    ["ack1","ACK Letter Sent 1"],
    ["dateDecRecFederal","Date Federal Disaster Declared Issued Rec'd"],
    ["declarationIssuedFederal","Was a Federal Disaster Dec Issued?"],
    ["dateDecRecState","Date State Disaster Declared Issued Rec'd"],
    ["declarationIssuedState","Was a State Disaster Dec Issued?"],
    ["dateDecRec","Date Disaster Declared Issued Rec'd"],
    ["declarationIssued","Was a Local Disaster Dec Issued?"],
    ["city","City"],
    ["county","County"],
    ["jurisdictionType","Jurisdiction Type"],
    ["incidentList","Incident Name"],
    ["updated","updated"]
    //no comma on last one
  ];
  checkIncidentNameValueWithIncidentListText();
  scribe.inicialReview();
  $("#county").prop("disabled", true);
  $("#city").prop("disabled", true);
  if ('<xsl:value-of select="/data/@dataid"/>'!=0){
     $("#county").prop("disabled", false);
                $("#city").prop("disabled", false);

                //startOf: doing stuff on update/edit
                var countySelectListOnUpdate = document.getElementById("county");
                sortOrderCounty(countySelectListOnUpdate.options[countySelectListOnUpdate.selectedIndex].text);
                var cityList = document.getElementById("city");
                if (countySelectListOnUpdate.options[countySelectListOnUpdate.selectedIndex].text == 'Select One') {
                  console.log('doing stuff on update/edit');
                    removeOptions(cityList);
                    addOption(cityList, "Select One", false);
                    addOption(cityList, "Unincorporated Areas", true);
                     //needs to be false so its not selected to begin with
                    for (var k = 0; k &lt; cityMatrix.length; k++) {
                        addOption(cityList, cityMatrix[k][1], false);
                    }addOption(cityList, "Other", false);
                } else {
                  console.log('else doing stuff on update/edit');
                    removeOptions(cityList);
                    addOption(cityList, "Select One", false);
                    addOption(cityList, "Unincorporated Areas", true);
                     // dont know
                    for (var k = 0; k &lt; cityMatrix.length; k++) {

                        if (cityMatrix[k][0] === countySelectListOnUpdate.options[countySelectListOnUpdate.selectedIndex].text) {
                            addOption(cityList, cityMatrix[k][1], false);
                        }
                    }addOption(cityList, "Other", false);
                }


                setTimeout(function() {
                  
                    selectOptionsIfExistsInArray();
                }, 1000);
                console.log('timeout runs');
  }

 var scribe={
      status: 0,
      autoRun: function() {},
      baseArray: [],
      changesMade: false,
      Evaluation: function() {
    var a=[];
    for(var i=0; i < scribe.fields4History.length; i++) {
      var b=document.getElementsByName(scribe.fields4History[i][0]);
      console.log(document.getElementsByName(scribe.fields4History[0][0]));
      console.log('document.getElementsByName(scribe.fields4History[0][0]) above');
      for(var k=0; k < b.length; k++) {
        var result=[];
        if(b[k].tagName==="SELECT") {
            var ms = b[k].selectedOptions;
            var msr =[];
            for(var msi=0; msi < ms.length; ms++){
               msr.push(ms[msi].text); 
            }
             result.push(scribe.fields4History[i][1]);
             result.push(msr.join(','));   
        } else if (b[k].type==="radio" || b[k].type==="checkbox") {
          result.push(scribe.fields4History[i][1]);
          var r;
          if(b[k].checked===true) {      
                r = b[k].value+'(Selected)';        
            result.push(r);
          } else {         
                r = b[k].value+'(Not Selected)';      
            result.push(r);
          }
        } else {
          result.push(scribe.fields4History[i][1]);
          result.push(b[k].value);
        }
        a.push(result);  
      }
    }
    return a;
  },
  
  inicialReview: function(){scribe.baseArray=scribe.Evaluation();},
  postReview: function() {
    var p=[];
    var f=scribe.Evaluation();
    for(var i=0; i < f.length; i++) {
      if(f[i][1] !== scribe.baseArray[i][1]) {
        p.push(f[i][0] + ': ' + f[i][1]);
      }
    }
    p=p.join('\r\n');
    if(p.length > 0) {
      scribe.changesMade=true;
      
    }
    return p;
  }
};