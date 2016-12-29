var totalRowVarMaster=function(i){
   var a = getTotalsFor(masterData[i][5]);
   var b = "rowYellow";
   var NaCount = parseFloat(a[12]) &gt; (0)?'Yes':'No';
   if(document.getElementById('AnticipatedInsurance1').checked==true){
    //hide total lines with N/A values
    b = "rowYellow hideValues";
  } else {
    //this will happen since no is selected
    //show or hide unvetted total lines on false
     b = a[10]===true?"rowYellow":"hideValues";
  }


      var thresholdResult = threshold(masterData[i][5]);
      var a = getTotalsFor(masterData[i][5]); //Get the total of a county
      threshold.TotalOnPage+=parseInt(thresholdResult); //totals all thresholds, not needed on page
      var Mets2 = parseFloat(a[8]) &gt;= parseFloat(thresholdResult)?'Yes':'No'; //is county total greater than or equal to county threshold
      var Mets = (NaCount=='Yes')?'(N/A)':Mets2; //are there N/As present
      var thresholdResultWithCommas = thresholdResult.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

//Below determines whether or not more is needed to reach county threshold or if reached and by how much over
      var Mets3 = "$ "+((thresholdResult-(a[8])).toFixed(2))+" *********MORE to REACH THRESHOLD ";
      var Mets33 = "$ "+(((a[8])-thresholdResult).toFixed(2))+" ****************OVER the THRESHOLD ";
      var Mets4 = 0;
      //var totalsAccurate = true;
      
      if((a[8]) &gt; thresholdResult){
        Mets4 = Mets33;
      } else {
        Mets4 = Mets3;
      }

      var Mets5 = Mets4.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");


  var yellowAm1 = (masterData[i][32]).toFixed(2);
  var yellowBm1 = (masterData[i][33]).toFixed(2);
  var yellowCm1 = (masterData[i][34]).toFixed(2);
  var yellowDm1 = (masterData[i][35]).toFixed(2);
  var yellowEm1 = (masterData[i][36]).toFixed(2);
  var yellowFm1 = (masterData[i][37]).toFixed(2);
  var yellowGm1 = (masterData[i][38]).toFixed(2);
  var yellowATm1 = (masterData[i][39]).toFixed(2);

  //yellow total rows
      
      newRow(t,t.rows.length,["","","","","MASTER Totals for "+masterData[i][5],"",a[0],yellowAm1,yellowBm1,yellowCm1,yellowDm1,yellowEm1,yellowFm1,yellowGm1,yellowATm1,Mets5+"$ "+thresholdResultWithCommas,Mets2,a[15],"",a[19],"FEMAS "+a[10],"NAS "+NaCount,"a","b","c","d","e","f","g","h","i",a[31]],b);



};