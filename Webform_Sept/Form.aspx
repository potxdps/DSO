<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Form.aspx.cs" Inherits="DSO.Form" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    
        <title>DSO Form</title>
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link href="Scripts/bootstrap.min.css" rel="stylesheet" />
    <link href="Scripts/bootstrap-dialog.min.css" rel="stylesheet" />
    <link href="Scripts/bootstrap-datepicker.min.css" rel="stylesheet" />
    <script type="text/javascript" src="Scripts/jquery.min.js"></script>
    <script type="text/javascript" src="Scripts/bootstrap.min.js"></script>
    <script src="Scripts/bootstrap-dialog.min.js"></script>
    <script src="Scripts/bootstrap-datepicker.min.js"></script>
    <style type="text/css">
        #container {  margin: 50px;
        }
        .form-group.required .control-label:after {
  content:"*";
  color:red;
}

    </style>

    <script type="text/javascript">
        var cancel = false;
        function setCancel() {
            cancel = true;
        }
        function removeOptions(obj) {
            if (obj == null) return;
            if (obj.options == null) return;
            obj.options.length = 0;
        }

        function iaAverage() {
   var a1 = document.getElementById("sfhCovByInsurance").value;
   var a2 = document.getElementById("mhCovByInsurance").value;
   var a3 = document.getElementById("mfuCovByInsurance").value;
   var num = 0;
   if (a1 != ("" || 0)) {
       num += 1
   } else {
       a1 = 0;
   };
   if (a2 != ("" || 0)) {
       num += 1
   } else {
       a2 = 0;
   };
   if (a3 != ("" || 0)) {
       num += 1
   } else {
       a3 = 0;
   };
   var avg = (parseFloat(a1) + parseFloat(a2) + parseFloat(a3)) / num;
   if (num === 0) {
    document.getElementById("totalsCovByInsurance").value = '';
       return false;

   } else {
       document.getElementById("totalsCovByInsurance").value = avg;
   }
}

        function autoSum() {
            var fields = ["totalsAffected", "totalsMinorDamage", "totalsMajorDamage", "totalsDestroyed", "numberTotal", "coveredTotal", "totalTotal", "sitesTotals", "repairCostTotals", "insuranceTotals", "sitesOtherTotal", "repairCostTotal", "insuranceCostTotal"];
            for (var i = 0; i < fields.length; i++) {
                var objs = document.getElementsByClassName(fields[i]);
                for (var h = 0; h < objs.length; h++) {
                    objs[h].idByClass = fields[i];
                    objs[h].onblur = function () {
                        var t = 0;
                        var a = document.getElementsByClassName(this.idByClass);
                        for (var b = 0; b < a.length; b++) {
                            if (a[b].value != '') {
                                var u = removeNonNumber(a[b].value);
                                t+= parseFloat(u);
                                a[b].value = comma(u);
                                /*if (isNaN(a[b].value) === false) {
                                    t += parseFloat(a[b].value)
                                }
                                else {
                                    numError(a[b].value);
                                    a[b].value = 0;

                                }*/
                            }
                        }
                        document.getElementById(this.idByClass).value = comma(t);
                    };
                }
            }
        }
        
        function removeNonNumber(a) {
            a = a.replace(/[^0-9.-]+/g, '');
            var t = 0;
            if (a != '') {
                if (isNaN(a) === false) {
                    t += parseFloat(a)
                } else {
                    return 0;

                }
            }
            return t.toFixed(2);
        }
        function comma(x) {
            if (isNaN(x) === true || x == "") {
                x == undefined ? x = '' : x = x;
                return x;
            }
            x = parseFloat(x).toFixed(2);
            return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            //return x;
        }
        function initPopUp() {
            BootstrapDialog.show({
                title: "How To",
                message: function (dialog) {
                    var $content = $('<div><ul><li>This is a tooltip - you can access other tooltips by clicking on <span id="tipexample" class="label label-info">i</span>.</li><li>Required Fields have a red asterisk <span style="color: red;">*</span>.</li><li>If you add your name and email to the submission you will receive a confirmation message.</li><li>For questions related to the new DSO submission process, please contact your TDEM District Coordinator (<a target="_blank" href="http://dps.texas.gov/dem/FieldResponse/index.htm" >List here</a>) or call the State Operations Center at (512) 424-2208.</li><li>That\'s it! Click anywhere to close this tooltip.</li></div>');
                    return $content;
                },

            });
        }
        function runError() {
                BootstrapDialog.show({
                    title: "Save Error",
                    message: function (dialog) {
                        var $content = $("<div>Not all the required fields have been filled out, find the inputs that have a red border to correct any required fields</div>");
                        return $content;
                    },

                });
        }
        function numError(a) {
            BootstrapDialog.show({
                title: "Must Be a Number",
                message: function (dialog) {
                    var $content = $('<div>The value listed <span class="label label-danger">' + a + '</span>must be a number </div>');
                    return $content;
                },

            });
        }
        function commandInfoWindow(clickedId, title, message) {
            $('#' + clickedId).click(function () {
                BootstrapDialog.show({
                    title: title,
                    message: function (dialog) {
                        var $content = $(message);
                        return $content;
                    },

                });
            })

        }
        
        function addOption(select, optionTxt, selected) {
            var option = document.createElement("option");
            option.text = optionTxt;
            option.id = optionTxt;
            option.selected = selected;
            try {
                select.add(option, null);
            }
            catch (ex) {
                select.add(option);
            }
        }
        var cityMatrix = [["Hill", "Abbott"], ["Hale", "Abernathy"], ["Lubbock", "Abernathy"], ["Jones", "Abilene"], ["Taylor", "Abilene"], ["Dawson", "Ackerly"], ["Martin", "Ackerly"], ["Collin", "Addison"], ["Dallas", "Addison"], ["Oldham", "Adrian"], ["Nueces", "Agua Dulce"], ["Hidalgo", "Alamo"], ["Bexar", "Alamo Heights"], ["Wood", "Alba"], ["Rains", "Alba"], ["Shackelford", "Albany"], ["Parker", "Aledo"], ["Jim Wells", "Alice"], ["Collin", "Allen"], ["Ellis", "Alma"], ["Brewster", "Alpine"], ["Cherokee", "Alto"], ["Hidalgo", "Alton"], ["Johnson", "Alvarado"], ["Brazoria", "Alvin"], ["Galveston", "Alvin"], ["Wise", "Alvord"], ["Potter", "Amarillo"], ["Randall", "Amarillo"], ["Liberty", "Ames"], ["Lamb", "Amherst"], ["Chambers", "Anahuac"], ["Grimes", "Anderson"], ["Andrews", "Andrews"], ["Brazoria", "Angleton"], ["Navarro", "Angus"], ["Collin", "Anna"], ["Parker", "Annetta"], ["Parker", "Annetta North"], ["Parker", "Annetta South"], ["Red River", "Annona"], ["Jones", "Anson"], ["El Paso", "Anthony"], ["Hockley", "Anton"], ["Nacogdoches", "Appleby"], ["Hill", "Aquilla"], ["Aransas", "Aransas Pass"], ["San Patricio", "Aransas Pass"], ["Nueces", "Aransas Pass"], ["Archer", "Archer City"], ["Fort Bend", "Arcola"], ["Denton", "Argyle"], ["Tarrant", "Arlington"], ["Smith", "Arp"], ["Dimmit", "Asherton"], ["Stonewall", "Aspermont"], ["Henderson", "Athens"], ["Cass", "Atlanta"], ["Denton", "Aubrey"], ["Wise", "Aurora"], ["Williamson", "Austin"], ["Travis", "Austin"], ["Hays", "Austin"], ["Refugio", "Austwell"], ["Red River", "Avery"], ["Cass", "Avinger"], ["Parker", "Azle"], ["Tarrant", "Azle"], ["Fannin", "Bailey"], ["Brazoria", "Bailey's Prairie"], ["Callahan", "Baird"], ["Dallas", "Balch Springs"], ["Bexar", "Balcones Heights"], ["Runnels", "Ballinger"], ["Reeves", "Balmorhea"], ["Bandera", "Bandera"], ["Brown", "Bangs"], ["Ellis", "Bardwell"], ["Navarro", "Barry"], ["Ward", "Barstow"], ["Williamson", "Bartlett"], ["Bell", "Bartlett"], ["Denton", "Bartonville"], ["Bastrop", "Bastrop"], ["Matagorda", "Bay City"], ["Galveston", "Bayou Vista"], ["Refugio", "Bayside"], ["Harris", "Baytown"], ["Chambers", "Baytown"], ["Cameron", "Bayview"], ["Chambers", "Beach City"], ["Hays", "Bear Creek"], ["Fort Bend", "Beasley"], ["Jefferson", "Beaumont"], ["Hardin", "Beaumont"], ["Orange", "Beaumont"], ["Panola", "Beckville"], ["Tarrant", "Bedford"], ["Grimes", "Bedias"], ["Travis", "Bee Cave"], ["Bee", "Beeville"], ["Harris", "Bellaire"], ["Clay", "Bellevue"], ["McLennan", "Bellmead"], ["Grayson", "Bells"], ["Austin", "Bellville"], ["Bell", "Belton"], ["Duval", "Benavides"], ["Tarrant", "Benbrook"], ["Knox", "Benjamin"], ["Henderson", "Berryville"], ["Burnet", "Bertram"], ["McLennan", "Beverly Hills"], ["Jefferson", "Bevil Oaks"], ["Hardin", "Bevil Oaks"], ["Reagan", "Big Lake"], ["Upshur", "Big Sandy"], ["Howard", "Big Spring"], ["Dimmit", "Big Wells"], ["Nueces", "Bishop"], ["Potter", "Bishop Hills"], ["Coke", "Blackwell"], ["Nolan", "Blackwell"], ["Blanco", "Blanco"], ["Brown", "Blanket"], ["Cass", "Bloomburg"], ["Navarro", "Blooming Grove"], ["Lamar", "Blossom"], ["Tarrant", "Blue Mound"], ["Collin", "Blue Ridge"], ["Hill", "Blum"], ["Kendall", "Boerne"], ["Red River", "Bogata"], ["Fannin", "Bonham"], ["Brazoria", "Bonney"], ["Ochiltree", "Booker"], ["Lipscomb", "Booker"], ["Hutchinson", "Borger"], ["Parmer", "Bovina"], ["Montague", "Bowie"], ["Wise", "Boyd"], ["Kinney", "Brackettville"], ["McCulloch", "Brady"], ["Brazoria", "Brazoria"], ["Hood", "Brazos Bend"], ["Austin", "Brazos Country"], ["Stephens", "Breckenridge"], ["Robertson", "Bremond"], ["Washington", "Brenham"], ["Travis", "Briarcliff"], ["Johnson", "Briaroaks"], ["Orange", "Bridge City"], ["Wise", "Bridgeport"], ["San Augustine", "Broaddus"], ["Coke", "Bronte"], ["Waller", "Brookshire"], ["Harris", "Brookside Village"], ["Brazoria", "Brookside Village"], ["Jasper", "Browndell"], ["Terry", "Brownfield"], ["Henderson", "Brownsboro"], ["Cameron", "Brownsville"], ["Brown", "Brownwood"], ["McLennan", "Bruceville-Eddy"], ["Falls", "Bruceville-Eddy"], ["Brazos", "Bryan"], ["Jack", "Bryson"], ["Milam", "Buckholts"], ["Hays", "Buda"], ["Leon", "Buffalo"], ["Taylor", "Buffalo Gap"], ["Lubbock", "Buffalo Springs"], ["Smith", "Bullard"], ["Cherokee", "Bullard"], ["Comal", "Bulverde"], ["Harris", "Bunker Hill Village"], ["Wichita", "Burkburnett"], ["Angelina", "Burke"], ["Tarrant", "Burleson"], ["Johnson", "Burleson"], ["Burnet", "Burnet"], ["Washington", "Burton"], ["Clay", "Byers"], ["Hill", "Bynum"], ["Sherman", "Cactus"], ["Moore", "Cactus"], ["Hunt", "Caddo Mills"], ["Burleson", "Caldwell"], ["Cooke", "Callisburg"], ["Robertson", "Calvert"], ["Milam", "Cameron"], ["Real", "Camp Wood"], ["Hunt", "Campbell"], ["Hemphill", "Canadian"], ["Henderson", "Caney City"], ["Van Zandt", "Canton"], ["Randall", "Canyon"], ["Eastland", "Carbon"], ["Hill", "Carl's Corner"], ["Washington", "Carmine"], ["Fayette", "Carmine"], ["Dimmit", "Carrizo Springs"], ["Denton", "Carrollton"], ["Collin", "Carrollton"], ["Dallas", "Carrollton"], ["Panola", "Carthage"], ["Wichita", "Cashion"], ["Bexar", "Castle Hills"], ["Medina", "Castroville"], ["Dallas", "Cedar Hill"], ["Ellis", "Cedar Hill"], ["Williamson", "Cedar Park"], ["Travis", "Cedar Park"], ["Hunt", "Celeste"], ["Denton", "Celina"], ["Collin", "Celina"], ["Grayson", "Celina"], ["Shelby", "Center"], ["Leon", "Centerville"], ["Henderson", "Chandler"], ["Hartley", "Channing"], ["Atascosa", "Charlotte"], ["Tyler", "Chester"], ["Wise", "Chico"], ["Childress", "Childress"], ["Hardeman", "Chillicothe"], ["Jefferson", "China"], ["Bexar", "China Grove"], ["Nacogdoches", "Chireno"], ["Atascosa", "Christine"], ["Guadalupe", "Cibolo"], ["Bexar", "Cibolo"], ["Eastland", "Cisco"], ["Donley", "Clarendon"], ["Red River", "Clarksville"], ["Upshur", "Clarksville City"], ["Gregg", "Clarksville City"], ["Armstrong", "Claude"], ["Galveston", "Clear Lake Shores"], ["Johnson", "Cleburne"], ["Liberty", "Cleveland"], ["Bosque", "Clifton"], ["El Paso", "Clint"], ["Brazoria", "Clute"], ["Callahan", "Clyde"], ["Howard", "Coahoma"], ["Dallas", "Cockrell Hill"], ["Henderson", "Coffee City"], ["San Jacinto", "Coldspring"], ["Coleman", "Coleman"], ["Brazos", "College Station"], ["Tarrant", "Colleyville"], ["Grayson", "Collinsville"], ["Tyler", "Colmesneil"], ["Mitchell", "Colorado City"], ["Colorado", "Columbus"], ["Comanche", "Comanche"], ["Cameron", "Combes"], ["Dallas", "Combine"], ["Kaufman", "Combine"], ["Hunt", "Commerce"], ["Hopkins", "Como"], ["Montgomery", "Conroe"], ["Bexar", "Converse"], ["Parker", "Cool"], ["Limestone", "Coolidge"], ["Delta", "Cooper"], ["Denton", "Coppell"], ["Dallas", "Coppell"], ["Tarrant", "Coppell"], ["Denton", "Copper Canyon"], ["Coryell", "Copperas Cove"], ["Lampasas", "Copperas Cove"], ["Bell", "Copperas Cove"], ["Denton", "Corinth"], ["Aransas", "Corpus Christi"], ["San Patricio", "Corpus Christi"], ["Nueces", "Corpus Christi"], ["Kleberg", "Corpus Christi"], ["Denton", "Corral City"], ["Polk", "Corrigan"], ["Navarro", "Corsicana"], ["Kaufman", "Cottonwood"], ["Burnet", "Cottonwood Shores"], ["LaSalle", "Cotulla"], ["Chambers", "Cove"], ["Hill", "Covington"], ["Kaufman", "Crandall"], ["Crane", "Crane"], ["Bosque", "Cranfills Gap"], ["McLennan", "Crawford"], ["Travis", "Creedmoor"], ["Hays", "Creedmoor"], ["Parker", "Cresson"], ["Hood", "Cresson"], ["Johnson", "Cresson"], ["Houston", "Crockett"], ["Crosby", "Crosbyton"], ["Callahan", "Cross Plains"], ["Denton", "Cross Roads"], ["Johnson", "Cross Timber"], ["Foard", "Crowell"], ["Tarrant", "Crowley"], ["Johnson", "Crowley"], ["Zavala", "Crystal City"], ["DeWitt", "Cuero"], ["Hopkins", "Cumby"], ["Cherokee", "Cuney"], ["Nacogdoches", "Cushing"], ["Montgomery", "Cut and Shoot"], ["Morris", "Daingerfield"], ["Liberty", "Daisetta"], ["Dallam", "Dalhart"], ["Hartley", "Dalhart"], ["Denton", "Dallas"], ["Collin", "Dallas"], ["Rockwall", "Dallas"], ["Dallas", "Dallas"], ["Kaufman", "Dallas"], ["Tarrant", "Dalworthington Gardens"], ["Brazoria", "Danbury"], ["Lipscomb", "Darrouzett"], ["Navarro", "Dawson"], ["Liberty", "Dayton"], ["Liberty", "Dayton Lakes"], ["Comanche", "De Leon"], ["Clay", "Dean"], ["Wise", "Decatur"], ["Hood", "DeCordova"], ["Harris", "Deer Park"], ["Bowie", "DeKalb"], ["Val Verde", "Del Rio"], ["Hudspeth", "Dell City"], ["Grayson", "Denison"], ["Denton", "Denton"], ["Gaines", "Denver City"], ["Yoakum", "Denver City"], ["Red River", "Deport"], ["Lamar", "Deport"], ["Dallas", "DeSoto"], ["Red River", "Detroit"], ["Liberty", "Devers"], ["Medina", "Devine"], ["Angelina", "Diboll"], ["Dickens", "Dickens"], ["Galveston", "Dickinson"], ["Frio", "Dilley"], ["Castro", "Dimmitt"], ["Denton", "Dish"], ["Fannin", "Dodd City"], ["Collingsworth", "Dodson"], ["Cass", "Domino"], ["Hidalgo", "Donna"], ["Grayson", "Dorchester"], ["Denton", "Double Oak"], ["Cass", "Douglassville"], ["Hays", "Dripping Springs"], ["Nueces", "Driscoll"], ["Erath", "Dublin"], ["Moore", "Dumas"], ["Dallas", "Duncanville"], ["Colorado", "Eagle Lake"], ["Maverick", "Eagle Pass"], ["Brown", "Early"], ["Lamb", "Earth"], ["Fort Bend", "East Bernard"], ["Wharton", "East Bernard"], ["Upshur", "East Mountain"], ["Gregg", "East Mountain"], ["Rains", "East Tawakoni"], ["Eastland", "Eastland"], ["Gregg", "Easton"], ["Rusk", "Easton"], ["Fannin", "Ector"], ["Hidalgo", "Edcouch"], ["Concho", "Eden"], ["Tarrant", "Edgecliff"], ["Van Zandt", "Edgewood"], ["Hidalgo", "Edinburg"], ["Hale", "Edmonson"], ["Jackson", "Edna"], ["Van Zandt", "Edom"], ["Wharton", "El Campo"], ["Webb", "El Cenizo"], ["Harris", "El Lago"], ["El Paso", "El Paso"], ["Schleicher", "Eldorado"], ["Wichita", "Electra"], ["Travis", "Elgin"], ["Bastrop", "Elgin"], ["Anderson", "Elkhart"], ["Bexar", "Elmendorf"], ["Wilson", "Elmendorf"], ["Hidalgo", "Elsa"], ["Navarro", "Emhouse"], ["Rains", "Emory"], ["Henderson", "Enchanted Oaks"], ["LaSalle", "Encinal"], ["Kaufman", "Ennis"], ["Ellis", "Ennis"], ["Starr", "Escobares"], ["Hall", "Estelline"], ["Dallas", "Euless"], ["Tarrant", "Euless"], ["Navarro", "Eureka"], ["Henderson", "Eustace"], ["Hamilton", "Evant"], ["Coryell", "Evant"], ["Tarrant", "Everman"], ["Kendall", "Fair Oaks Ranch"], ["Comal", "Fair Oaks Ranch"], ["Bexar", "Fair Oaks Ranch"], ["Fort Bend", "Fairchilds"], ["Freestone", "Fairfield"], ["Collin", "Fairview"], ["Brooks", "Falfurrias"], ["Karnes", "Falls City"], ["Dallas", "Farmers Branch"], ["Collin", "Farmersville"], ["Parmer", "Farwell"], ["Rockwall", "Fate"], ["Fayette", "Fayetteville"], ["Dallas", "Ferris"], ["Ellis", "Ferris"], ["Fayette", "Flatonia"], ["Williamson", "Florence"], ["Wilson", "Floresville"], ["Denton", "Flower Mound"], ["Tarrant", "Flower Mound"], ["Floyd", "Floydada"], ["Lipscomb", "Follett"], ["Tarrant", "Forest Hill"], ["Kaufman", "Forney"], ["Howard", "Forsan"], ["Pecos", "Fort Stockton"], ["Wise", "Fort Worth"], ["Denton", "Fort Worth"], ["Parker", "Fort Worth"], ["Dallas", "Fort Worth"], ["Tarrant", "Fort Worth"], ["Johnson", "Fort Worth"], ["Robertson", "Franklin"], ["Henderson", "Frankston"], ["Anderson", "Frankston"], ["Gillespie", "Fredericksburg"], ["Brazoria", "Freeport"], ["Duval", "Freer"], ["Harris", "Friendswood"], ["Brazoria", "Friendswood"], ["Galveston", "Friendswood"], ["Parmer", "Friona"], ["Denton", "Frisco"], ["Collin", "Frisco"], ["Moore", "Fritch"], ["Hutchinson", "Fritch"], ["Navarro", "Frost"], ["Van Zandt", "Fruitvale"], ["Fort Bend", "Fulshear"], ["Aransas", "Fulton"], ["Cooke", "Gainesville"], ["Harris", "Galena Park"], ["Cherokee", "Gallatin"], ["Galveston", "Galveston"], ["Jackson", "Ganado"], ["Comal", "Garden Ridge"], ["Collin", "Garland"], ["Dallas", "Garland"], ["Ellis", "Garrett"], ["Nacogdoches", "Garrison"], ["Panola", "Gary"], ["Coryell", "Gatesville"], ["Live Oak", "George West"], ["Williamson", "Georgetown"], ["McLennan", "Gholson"], ["Lee", "Giddings"], ["Upshur", "Gilmer"], ["Upshur", "Gladewater"], ["Gregg", "Gladewater"], ["Somervell", "Glen Rose"], ["Dallas", "Glenn Heights"], ["Ellis", "Glenn Heights"], ["Johnson", "Godley"], ["Ector", "Goldsmith"], ["Mills", "Goldthwaite"], ["Goliad", "Goliad"], ["McLennan", "Golinda"], ["Falls", "Golinda"], ["Gonzales", "Gonzales"], ["Navarro", "Goodlow"], ["Polk", "Goodrich"], ["Palo Pinto", "Gordon"], ["Knox", "Goree"], ["Eastland", "Gorman"], ["Comanche", "Gorman"], ["Palo Pinto", "Graford"], ["Young", "Graham"], ["Hood", "Granbury"], ["Dallas", "Grand Prairie"], ["Tarrant", "Grand Prairie"], ["Ellis", "Grand Prairie"], ["Van Zandt", "Grand Saline"], ["Ward", "Grandfalls"], ["Johnson", "Grandview"], ["Williamson", "Granger"], ["Burnet", "Granite Shoals"], ["Hidalgo", "Granjeno"], ["Houston", "Grapeland"], ["Denton", "Grapevine"], ["Dallas", "Grapevine"], ["Tarrant", "Grapevine"], ["Kaufman", "Grays Prairie"], ["Hunt", "Greenville"], ["San Patricio", "Gregory"], ["Bexar", "Grey Forest"], ["Limestone", "Groesbeck"], ["Carson", "Groom"], ["Jefferson", "Groves"], ["Trinity", "Groveton"], ["Hansford", "Gruver"], ["Henderson", "Gun Barrel City"], ["Grayson", "Gunter"], ["Comanche", "Gustine"], ["Denton", "Hackberry"], ["Hale", "Hale Center"], ["Lavaca", "Hallettsville"], ["McLennan", "Hallsburg"], ["Harrison", "Hallsville"], ["Tarrant", "Haltom City"], ["Hamilton", "Hamilton"], ["Fisher", "Hamlin"], ["Jones", "Hamlin"], ["Randall", "Happy"], ["Swisher", "Happy"], ["Liberty", "Hardin"], ["Bell", "Harker Heights"], ["Cameron", "Harlingen"], ["Castro", "Hart"], ["Haskell", "Haskell"], ["Denton", "Haslet"], ["Tarrant", "Haslet"], ["Hunt", "Hawk Cove"], ["Wood", "Hawkins"], ["Jones", "Hawley"], ["Hays", "Hays"], ["Robertson", "Hearne"], ["Rockwall", "Heath"], ["Kaufman", "Heath"], ["Denton", "Hebron"], ["Collin", "Hebron"], ["Donley", "Hedley"], ["Harris", "Hedwig Village"], ["Bexar", "Helotes"], ["Sabine", "Hemphill"], ["Waller", "Hempstead"], ["Rusk", "Henderson"], ["Clay", "Henrietta"], ["Deaf Smith", "Hereford"], ["McLennan", "Hewitt"], ["Denton", "Hickory Creek"], ["Hamilton", "Hico"], ["Hidalgo", "Hidalgo"], ["Smith", "Hideaway"], ["Lipscomb", "Higgins"], ["Burnet", "Highland Haven"], ["Dallas", "Highland Park"], ["Denton", "Highland Village"], ["Bexar", "Hill Country Village"], ["Brazoria", "Hillcrest Village"], ["Hill", "Hillsboro"], ["Harris", "Hilshire Village"], ["Brazoria", "Hitchcock"], ["Galveston", "Hitchcock"], ["Brazoria", "Holiday Lakes"], ["Bell", "Holland"], ["Archer", "Holliday"], ["Bexar", "Hollywood Park"], ["Medina", "Hondo"], ["Fannin", "Honey Grove"], ["Bowie", "Hooks"], ["El Paso", "Horizon City"], ["Burnet", "Horseshoe Bay"], ["Llano", "Horseshoe Bay"], ["Montgomery", "Houston"], ["Harris", "Houston"], ["Fort Bend", "Houston"], ["Brazoria", "Houston"], ["Donley", "Howardwick"], ["Grayson", "Howe"], ["Hill", "Hubbard"], ["Angelina", "Hudson"], ["Parker", "Hudson Oaks"], ["Morris", "Hughes Springs"], ["Cass", "Hughes Springs"], ["Harris", "Humble"], ["Harris", "Hunters Creek Village"], ["Angelina", "Huntington"], ["Walker", "Huntsville"], ["Tarrant", "Hurst"], ["Dallas", "Hutchins"], ["Williamson", "Hutto"], ["Shelby", "Huxley"], ["Lubbock", "Idalou"], ["Taylor", "Impact"], ["Cameron", "Indian Lake"], ["Austin", "Industry"], ["San Patricio", "Ingleside"], ["San Patricio", "Ingleside On The Bay"], ["Kerr", "Ingram"], ["Grimes", "Iola"], ["Brazoria", "Iowa Colony"], ["Wichita", "Iowa Park"], ["Pecos", "Iraan"], ["Bosque", "Iredell"], ["Dallas", "Irving"], ["Tarrant", "Irving"], ["Ellis", "Italy"], ["Hill", "Itasca"], ["Tyler", "Ivanhoe"], ["Harris", "Jacinto City"], ["Jack", "Jacksboro"], ["Cherokee", "Jacksonville"], ["Galveston", "Jamaica Beach"], ["Williamson", "Jarrell"], ["Jasper", "Jasper"], ["Kent", "Jayton"], ["Marion", "Jefferson"], ["Harris", "Jersey Village"], ["Leon", "Jewett"], ["Shelby", "Joaquin"], ["Blanco", "Johnson City"], ["Clay", "Jolly"], ["Brazoria", "Jones Creek"], ["Travis", "Jonestown"], ["Hunt", "Josephine"], ["Collin", "Josephine"], ["Johnson", "Joshua"], ["Atascosa", "Jourdanton"], ["Kimble", "Junction"], ["Denton", "Justin"], ["Karnes", "Karnes City"], ["Waller", "Katy"], ["Harris", "Katy"], ["Fort Bend", "Katy"], ["Kaufman", "Kaufman"], ["Johnson", "Keene"], ["Tarrant", "Keller"], ["Galveston", "Kemah"], ["Kaufman", "Kemp"], ["Lampasas", "Kempner"], ["Fort Bend", "Kendleton"], ["Karnes", "Kenedy"], ["Liberty", "Kenefick"], ["Houston", "Kennard"], ["Tarrant", "Kennedale"], ["Henderson", "Kerens"], ["Navarro", "Kerens"], ["Winkler", "Kermit"], ["Kerr", "Kerrville"], ["Gregg", "Kilgore"], ["Rusk", "Kilgore"], ["Coryell", "Killeen"], ["Bell", "Killeen"], ["Kleberg", "Kingsville"], ["Bexar", "Kirby"], ["Jasper", "Kirbyville"], ["Freestone", "Kirvin"], ["Grayson", "Knollwood"], ["Knox", "Knox City"], ["Limestone", "Kosse"], ["Hardin", "Kountze"], ["Swisher", "Kress"], ["Denton", "Krugerville"], ["Denton", "Krum"], ["Brazos", "Kurten"], ["Hays", "Kyle"], ["Cameron", "La Feria"], ["Fayette", "La Grange"], ["Starr", "La Grulla"], ["Hidalgo", "La Joya"], ["Galveston", "La Marque"], ["Harris", "La Porte"], ["Wilson", "La Vernia"], ["Hidalgo", "La Villa"], ["Jackson", "La Ward"], ["Medina", "LaCoste"], ["McLennan", "Lacy-Lakeview"], ["Fannin", "Ladonia"], ["Travis", "Lago Vista"], ["Cameron", "Laguna Vista"], ["Wise", "Lake Bridgeport"], ["San Patricio", "Lake City"], ["Denton", "Lake Dallas"], ["Brazoria", "Lake Jackson"], ["Randall", "Lake Tanglewood"], ["Tarrant", "Lake Worth"], ["Gregg", "Lakeport"], ["San Patricio", "Lakeside (San Patricio)"], ["Tarrant", "Lakeside (Tarrant)"], ["Wichita", "Lakeside City"], ["Archer", "Lakeside City"], ["Hall", "Lakeview"], ["Travis", "Lakeway"], ["Denton", "Lakewood Village"], ["Dawson", "Lamesa"], ["Lampasas", "Lampasas"], ["Dallas", "Lancaster"], ["Ellis", "Lancaster"], ["Webb", "Laredo"], ["Houston", "Latexo"], ["Collin", "Lavon"], ["Taylor", "Lawn"], ["Harris", "League City"], ["Brazoria", "League City"], ["Galveston", "League City"], ["Real", "Leakey"], ["Williamson", "Leander"], ["Travis", "Leander"], ["Bowie", "Leary"], ["Gray", "Lefors"], ["Bexar", "Leon Valley"], ["Leon", "Leona"], ["Fannin", "Leonard"], ["McLennan", "Leroy"], ["Hockley", "Levelland"], ["Denton", "Lewisville"], ["Lee", "Lexington"], ["Liberty", "Liberty"], ["Williamson", "Liberty Hill"], ["Denton", "Lincoln Park"], ["Smith", "Lindale"], ["Cass", "Linden"], ["Cooke", "Lindsay"], ["Hood", "Lipan"], ["Denton", "Little Elm"], ["Bell", "Little River Academy"], ["Lamb", "Littlefield"], ["Bexar", "Live Oak"], ["Brazoria", "Liverpool"], ["Polk", "Livingston"], ["Llano", "Llano"], ["Caldwell", "Lockhart"], ["Floyd", "Lockney"], ["Henderson", "Log Cabin"], ["Lampasas", "Lometa"], ["Hunt", "Lone Oak"], ["Morris", "Lone Star"], ["Harrison", "Longview"], ["Gregg", "Longview"], ["Mitchell", "Loraine"], ["McLennan", "Lorena"], ["Crosby", "Lorenzo"], ["Cameron", "Los Fresnos"], ["Cameron", "Los Indios"], ["Dawson", "Los Ybanez"], ["Falls", "Lott"], ["Houston", "Lovelady"], ["Collin", "Lowry Crossing"], ["Lubbock", "Lubbock"], ["Collin", "Lucas"], ["Jones", "Lueders"], ["Shackelford", "Lueders"], ["Angelina", "Lufkin"], ["Guadalupe", "Luling"], ["Caldwell", "Luling"], ["Hardin", "Lumberton"], ["Willacy", "Lyford"], ["Bexar", "Lytle"], ["Medina", "Lytle"], ["Atascosa", "Lytle"], ["Van Zandt", "Mabank"], ["Henderson", "Mabank"], ["Kaufman", "Mabank"], ["Madison", "Madisonville"], ["Montgomery", "Magnolia"], ["Henderson", "Malakoff"], ["Hill", "Malone"], ["Travis", "Manor"], ["Tarrant", "Mansfield"], ["Ellis", "Mansfield"], ["Johnson", "Mansfield"], ["Brazoria", "Manvel"], ["Burnet", "Marble Falls"], ["Presidio", "Marfa"], ["Cass", "Marietta"], ["Guadalupe", "Marion"], ["Falls", "Marlin"], ["Leon", "Marquez"], ["Harrison", "Marshall"], ["McLennan", "Mart"], ["Limestone", "Mart"], ["Guadalupe", "Martindale"], ["Caldwell", "Martindale"], ["Mason", "Mason"], ["Motley", "Matador"], ["San Patricio", "Mathis"], ["Bowie", "Maud"], ["Ellis", "Maypearl"], ["Hidalgo", "McAllen"], ["Upton", "McCamey"], ["Coryell", "McGregor"], ["McLennan", "McGregor"], ["Collin", "McKinney"], ["Gray", "McLean"], ["Rockwall", "McLendon-Chisholm"], ["Kaufman", "McLendon-Chisholm"], ["Terry", "Meadow"], ["Burnet", "Meadowlakes"], ["Harris", "Meadows Place"], ["Fort Bend", "Meadows Place"], ["Archer", "Megargel"], ["Collin", "Melissa"], ["McCulloch", "Melvin"], ["Hall", "Memphis"], ["Menard", "Menard"], ["Hidalgo", "Mercedes"], ["Bosque", "Meridian"], ["Taylor", "Merkel"], ["Hill", "Mertens"], ["Irion", "Mertzon"], ["Dallas", "Mesquite"], ["Kaufman", "Mesquite"], ["Limestone", "Mexia"], ["Roberts", "Miami"], ["Martin", "Midland"], ["Midland", "Midland"], ["Ellis", "Midlothian"], ["Madison", "Midway"], ["Milam", "Milano"], ["Navarro", "Mildred"], ["Runnels", "Miles"], ["Ellis", "Milford"], ["Titus", "Miller's Cove"], ["Parker", "Millsap"], ["Wood", "Mineola"], ["Palo Pinto", "Mineral Wells"], ["Parker", "Mineral Wells"], ["Palo Pinto", "Mingus"], ["Hidalgo", "Mission"], ["Harris", "Missouri City"], ["Fort Bend", "Missouri City"], ["Wheeler", "Mobeetie"], ["Rockwall", "Mobile City"], ["Winkler", "Monahans"], ["Ward", "Monahans"], ["Liberty", "Mont Belvieu"], ["Harris", "Mont Belvieu"], ["Chambers", "Mont Belvieu"], ["Montgomery", "Montgomery"], ["McLennan", "Moody"], ["Henderson", "Moore Station"], ["Shackelford", "Moran"], ["Bosque", "Morgan"], ["Harris", "Morgan's Point"], ["Bell", "Morgan's Point Resort"], ["Cochran", "Morton"], ["Lavaca", "Moulton"], ["Hill", "Mount Calm"], ["Rusk", "Mount Enterprise"], ["Titus", "Mount Pleasant"], ["Franklin", "Mount Vernon"], ["Hays", "Mountain City"], ["Cooke", "Muenster"], ["Bailey", "Muleshoe"], ["Mills", "Mullin"], ["Knox", "Munday"], ["Henderson", "Murchison"], ["Collin", "Murphy"], ["Navarro", "Mustang"], ["Travis", "Mustang Ridge"], ["Caldwell", "Mustang Ridge"], ["Nacogdoches", "Nacogdoches"], ["Morris", "Naples"], ["Bowie", "Nash"], ["Harris", "Nassau Bay"], ["Medina", "Natalia"], ["Navarro", "Navarro"], ["Brazos", "Navasota"], ["Grimes", "Navasota"], ["Castro", "Nazareth"], ["Jefferson", "Nederland"], ["Fort Bend", "Needville"], ["Harrison", "Nesbitt"], ["Collin", "Nevada"], ["Guadalupe", "New Berlin"], ["Bexar", "New Berlin"], ["Bowie", "New Boston"], ["Comal", "New Braunfels"], ["Guadalupe", "New Braunfels"], ["Smith", "New Chapel Hill"], ["Lubbock", "New Deal"], ["Wise", "New Fairview"], ["Lynn", "New Home"], ["Collin", "New Hope"], ["Rusk", "New London"], ["Cherokee", "New Summerfield"], ["Walker", "New Waverly"], ["Wise", "Newark"], ["Young", "Newcastle"], ["Newton", "Newton"], ["Hunt", "Neylandville"], ["Hays", "Niederwald"], ["Caldwell", "Niederwald"], ["Wilson", "Nixon"], ["Gonzales", "Nixon"], ["Montague", "Nocona"], ["Bell", "Nolanville"], ["Jefferson", "Nome"], ["Smith", "Noonday"], ["DeWitt", "Nordheim"], ["Leon", "Normangee"], ["Madison", "Normangee"], ["Liberty", "North Cleveland"], ["Tarrant", "North Richland Hills"], ["Denton", "Northlake"], ["Coleman", "Novice"], ["Kaufman", "Oak Grove"], ["Ellis", "Oak Leaf"], ["Denton", "Oak Point"], ["Cooke", "Oak Ridge (Cooke)"], ["Kaufman", "Oak Ridge (Kaufman)"], ["Montgomery", "Oak Ridge North"], ["Navarro", "Oak Valley"], ["Leon", "Oakwood"], ["Haskell", "O'Brien"], ["San Patricio", "Odem"], ["Ector", "Odessa"], ["Midland", "Odessa"], ["Dawson", "O'Donnell"], ["Lynn", "O'Donnell"], ["Coryell", "Oglesby"], ["Liberty", "Old River-Winfree"], ["Chambers", "Old River-Winfree"], ["Bexar", "Olmos Park"], ["Young", "Olney"], ["Lamb", "Olton"], ["Morris", "Omaha"], ["Polk", "Onalaska"], ["Hockley", "Opdyke West"], ["Orange", "Orange"], ["Jim Wells", "Orange Grove"], ["Fort Bend", "Orchard"], ["Upshur", "Ore City"], ["Marion", "Ore City"], ["Smith", "Overton"], ["Rusk", "Overton"], ["Dallas", "Ovilla"], ["Ellis", "Ovilla"], ["Brazoria", "Oyster Creek"], ["Cottle", "Paducah"], ["Concho", "Paint Rock"], ["Matagorda", "Palacios"], ["Anderson", "Palestine"], ["Randall", "Palisades"], ["Cameron", "Palm Valley"], ["Ellis", "Palmer"], ["Hidalgo", "Palmhurst"], ["Hidalgo", "Palmview"], ["Gray", "Pampa"], ["Carson", "Panhandle"], ["Montgomery", "Panorama Village"], ["Tarrant", "Pantego"], ["Wise", "Paradise"], ["Lamar", "Paris"], ["Collin", "Parker"], ["Harris", "Pasadena"], ["Waller", "Pattison"], ["Montgomery", "Patton Village"], ["Henderson", "Payne Springs"], ["Harris", "Pearland"], ["Fort Bend", "Pearland"], ["Brazoria", "Pearland"], ["Galveston", "Pearland"], ["Frio", "Pearsall"], ["Delta", "Pecan Gap"], ["Fannin", "Pecan Gap"], ["Ellis", "Pecan Hill"], ["Reeves", "Pecos"], ["Tarrant", "Pelican Bay"], ["Hill", "Penelope"], ["Hidalgo", "Penitas"], ["Ochiltree", "Perryton"], ["Hale", "Petersburg"], ["Clay", "Petrolia"], ["Nueces", "Petronila"], ["Williamson", "Pflugerville"], ["Travis", "Pflugerville"], ["Hidalgo", "Pharr"], ["Denton", "Pilot Point"], ["Collin", "Pilot Point"], ["Orange", "Pine Forest"], ["Waller", "Pine Island"], ["Orange", "Pinehurst"], ["Sabine", "Pineland"], ["Harris", "Piney Point Village"], ["Camp", "Pittsburg"], ["Yoakum", "Plains"], ["Hale", "Plainview"], ["Denton", "Plano"], ["Collin", "Plano"], ["Fort Bend", "Pleak"], ["Wichita", "Pleasant Valley"], ["Atascosa", "Pleasanton"], ["Montgomery", "Plum Grove"], ["Liberty", "Plum Grove"], ["Rains", "Point"], ["San Jacinto", "Point Blank"], ["Calhoun", "Point Comfort"], ["Travis", "Point Venture"], ["Denton", "Ponder"], ["Aransas", "Port Aransas"], ["Nueces", "Port Aransas"], ["Jefferson", "Port Arthur"], ["Orange", "Port Arthur"], ["Cameron", "Port Isabel"], ["Calhoun", "Port Lavaca"], ["Jefferson", "Port Neches"], ["San Patricio", "Portland"], ["Garza", "Post"], ["Kaufman", "Post Oak Bend"], ["Atascosa", "Poteet"], ["Wilson", "Poth"], ["Grayson", "Pottsboro"], ["Navarro", "Powell"], ["Henderson", "Poynor"], ["Waller", "Prairie View"], ["Jim Wells", "Premont"], ["Presidio", "Presidio"], ["Cameron", "Primera"], ["Collin", "Princeton"], ["Hidalgo", "Progreso"], ["Hidalgo", "Progreso Lakes"], ["Denton", "Prosper"], ["Collin", "Prosper"], ["Denton", "Providence Village"], ["Callahan", "Putnam"], ["Ward", "Pyote"], ["Hardeman", "Quanah"], ["Cass", "Queen City"], ["Hunt", "Quinlan"], ["Brazoria", "Quintana"], ["Briscoe", "Quitaque"], ["Wood", "Quitman"], ["Crosby", "Ralls"], ["Cameron", "Rancho Viejo"], ["Eastland", "Ranger"], ["Cameron", "Rangerville"], ["Upton", "Rankin"], ["Lubbock", "Ransom Canyon"], ["Fannin", "Ravenna"], ["Willacy", "Raymondville"], ["Bowie", "Red Lick"], ["Dallas", "Red Oak"], ["Ellis", "Red Oak"], ["Bowie", "Redwater"], ["Refugio", "Refugio"], ["Rusk", "Reklaw"], ["Cherokee", "Reklaw"], ["Lamar", "Reno (Lamar)"], ["Parker", "Reno (Parker)"], ["Tarrant", "Reno (Parker)"], ["Navarro", "Retreat"], ["Wise", "Rhome"], ["Ellis", "Rice"], ["Navarro", "Rice"], ["Collin", "Richardson"], ["Dallas", "Richardson"], ["Navarro", "Richland"], ["Tarrant", "Richland Hills"], ["San Saba", "Richland Springs"], ["Fort Bend", "Richmond"], ["Brazoria", "Richwood"], ["McLennan", "Riesel"], ["Webb", "Rio Bravo"], ["Starr", "Rio Grande City"], ["Cameron", "Rio Hondo"], ["Johnson", "Rio Vista"], ["Eastland", "Rising Star"], ["Tarrant", "River Oaks"], ["Walker", "Riverside"], ["Denton", "Roanoke"], ["Motley", "Roaring Springs"], ["Coke", "Robert Lee"], ["McLennan", "Robinson"], ["Nueces", "Robstown"], ["Fisher", "Roby"], ["Haskell", "Rochester"], ["Milam", "Rockdale"], ["Aransas", "Rockport"], ["Edwards", "Rocksprings"], ["Collin", "Rockwall"], ["Rockwall", "Rockwall"], ["Camp", "Rocky Mound"], ["Bell", "Rogers"], ["Travis", "Rollingwood"], ["Starr", "Roma"], ["Montgomery", "Roman Forest"], ["Hockley", "Ropesville"], ["Nolan", "Roscoe"], ["Orange", "Rose City"], ["Jefferson", "Rose Hill Acres"], ["Hardin", "Rose Hill Acres"], ["Falls", "Rosebud"], ["Fort Bend", "Rosenberg"], ["McLennan", "Ross"], ["Kaufman", "Rosser"], ["Fisher", "Rotan"], ["Blanco", "Round Mountain"], ["Williamson", "Round Rock"], ["Travis", "Round Rock"], ["Fayette", "Round Top"], ["Rockwall", "Rowlett"], ["Dallas", "Rowlett"], ["Lamar", "Roxton"], ["Hunt", "Royse City"], ["Collin", "Royse City"], ["Rockwall", "Royse City"], ["Haskell", "Rule"], ["Wise", "Runaway Bay"], ["Karnes", "Runge"], ["Cherokee", "Rusk"], ["Uvalde", "Sabinal"], ["Collin", "Sachse"], ["Dallas", "Sachse"], ["Grayson", "Sadler"], ["Tarrant", "Saginaw"], ["Bexar", "Saint Hedwig"], ["Montague", "Saint Jo"], ["Collin", "Saint Paul"], ["Bell", "Salado"], ["Tom Green", "San Angelo"], ["Comal", "San Antonio"], ["Bexar", "San Antonio"], ["Medina", "San Antonio"], ["San Augustine", "San Augustine"], ["Cameron", "San Benito"], ["Jim Wells", "San Diego"], ["Duval", "San Diego"], ["Austin", "San Felipe"], ["Hidalgo", "San Juan"], ["Travis", "San Leanna"], ["Guadalupe", "San Marcos"], ["Hays", "San Marcos"], ["Caldwell", "San Marcos"], ["San Patricio", "San Patricio"], ["Nueces", "San Patricio"], ["Willacy", "San Perlita"], ["San Saba", "San Saba"], ["Parker", "Sanctuary"], ["Brazoria", "Sandy Point"], ["Hutchinson", "Sanford"], ["Denton", "Sanger"], ["Cooke", "Sanger"], ["Tarrant", "Sansom Park"], ["Coleman", "Santa Anna"], ["Guadalupe", "Santa Clara"], ["Galveston", "Santa Fe"], ["Cameron", "Santa Rosa"], ["Fannin", "Savoy"], ["Comal", "Schertz"], ["Guadalupe", "Schertz"], ["Bexar", "Schertz"], ["Fayette", "Schulenburg"], ["Clay", "Scotland"], ["Archer", "Scotland"], ["Harrison", "Scottsville"], ["Kaufman", "Scurry"], ["Harris", "Seabrook"], ["Calhoun", "Seadrift"], ["Dallas", "Seagoville"], ["Kaufman", "Seagoville"], ["Gaines", "Seagraves"], ["Austin", "Sealy"], ["Guadalupe", "Seguin"], ["Comal", "Selma"], ["Guadalupe", "Selma"], ["Bexar", "Selma"], ["Gaines", "Seminole"], ["Polk", "Seven Oaks"], ["Henderson", "Seven Points"], ["Baylor", "Seymour"], ["Denton", "Shady Shores"], ["Lubbock", "Shallowater"], ["Wheeler", "Shamrock"], ["Bexar", "Shavano Park"], ["Montgomery", "Shenandoah"], ["San Jacinto", "Shepherd"], ["Grayson", "Sherman"], ["Lavaca", "Shiner"], ["Harris", "Shoreacres"], ["Hardin", "Silsbee"], ["Briscoe", "Silverton"], ["Fort Bend", "Simonton"], ["San Patricio", "Sinton"], ["Carson", "Skellytown"], ["Lubbock", "Slaton"], ["Gonzales", "Smiley"], ["Bastrop", "Smithville"], ["Hockley", "Smyer"], ["Burleson", "Snook"], ["Scurry", "Snyder"], ["El Paso", "Socorro"], ["Bexar", "Somerset"], ["Burleson", "Somerville"], ["Sutton", "Sonora"], ["Hardin", "Sour Lake"], ["Harris", "South Houston"], ["Coryell", "South Mountain"], ["Cameron", "South Padre Island"], ["Denton", "Southlake"], ["Tarrant", "Southlake"], ["Grayson", "Southmayd"], ["Harris", "Southside Place"], ["Hansford", "Spearman"], ["Montgomery", "Splendora"], ["Kinney", "Spofford"], ["Harris", "Spring Valley"], ["Lamb", "Springlake"], ["Parker", "Springtown"], ["Dickens", "Spur"], ["Harris", "Stafford"], ["Fort Bend", "Stafford"], ["Montgomery", "Stagecoach"], ["Haskell", "Stamford"], ["Jones", "Stamford"], ["Martin", "Stanton"], ["Guadalupe", "Staples"], ["Caldwell", "Staples"], ["Henderson", "Star Harbor"], ["Erath", "Stephenville"], ["Sterling", "Sterling City"], ["Hutchinson", "Stinnett"], ["Wilson", "Stockdale"], ["Sherman", "Stratford"], ["Palo Pinto", "Strawn"], ["Freestone", "Streetman"], ["Navarro", "Streetman"], ["Lamb", "Sudan"], ["Fort Bend", "Sugar Land"], ["Hidalgo", "Sullivan City"], ["Hopkins", "Sulphur Springs"], ["Lamar", "Sun Valley"], ["Hockley", "Sundown"], ["Dallas", "Sunnyvale"], ["Kaufman", "Sunnyvale"], ["Moore", "Sunray"], ["Burnet", "Sunrise Beach Village"], ["Llano", "Sunrise Beach Village"], ["Travis", "Sunset Valley"], ["Brazoria", "Surfside Beach"], ["Brazoria", "Sweeny"], ["Nolan", "Sweetwater"], ["San Patricio", "Taft"], ["Lynn", "Tahoka"], ["Titus", "Talco"], ["Kaufman", "Talty"], ["Rusk", "Tatum"], ["Panola", "Tatum"], ["Williamson", "Taylor"], ["Harris", "Taylor Lake Village"], ["Jefferson", "Taylor Landing"], ["Freestone", "Teague"], ["Limestone", "Tehuacana"], ["Bell", "Temple"], ["Shelby", "Tenaha"], ["Kaufman", "Terrell"], ["Bexar", "Terrell Hills"], ["Bowie", "Texarkana"], ["Chambers", "Texas City"], ["Galveston", "Texas City"], ["Sherman", "Texhoma"], ["Dallam", "Texline"], ["Denton", "The Colony"], ["Fort Bend", "Thompsons"], ["Williamson", "Thorndale"], ["Milam", "Thorndale"], ["Limestone", "Thornton"], ["Ward", "Thorntonville"], ["Williamson", "Thrall"], ["Live Oak", "Three Rivers"], ["Throckmorton", "Throckmorton"], ["Galveston", "Tiki Island"], ["Randall", "Timbercreek Canyon"], ["Shelby", "Timpson"], ["Grayson", "Tioga"], ["Hopkins", "Tira"], ["Lamar", "Toco"], ["Grimes", "Todd Mission"], ["Hood", "Tolar"], ["Grayson", "Tom Bean"], ["Montgomery", "Tomball"], ["Harris", "Tomball"], ["Henderson", "Tool"], ["Reeves", "Toyah"], ["Taylor", "Trent"], ["Grayson", "Trenton"], ["Fannin", "Trenton"], ["Henderson", "Trinidad"], ["Navarro", "Trinidad"], ["Trinity", "Trinity"], ["Denton", "Trophy Club"], ["Tarrant", "Trophy Club"], ["Smith", "Troup"], ["Cherokee", "Troup"], ["Bell", "Troy"], ["Swisher", "Tulia"], ["Hall", "Turkey"], ["Taylor", "Tuscola"], ["Taylor", "Tye"], ["Smith", "Tyler"], ["Hays", "Uhland"], ["Caldwell", "Uhland"], ["Harrison", "Uncertain"], ["Upshur", "Union Grove"], ["Hunt", "Union Valley"], ["Guadalupe", "Universal City"], ["Bexar", "Universal City"], ["Dallas", "University Park"], ["Uvalde", "Uvalde"], ["Jeff Davis", "Valentine"], ["Bosque", "Valley Mills"], ["McLennan", "Valley Mills"], ["Cooke", "Valley View"], ["Van Zandt", "Van"], ["Collin", "Van Alstyne"], ["Grayson", "Van Alstyne"], ["Culberson", "Van Horn"], ["Oldham", "Vega"], ["Ellis", "Venus"], ["Johnson", "Venus"], ["Wilbarger", "Vernon"], ["Victoria", "Victoria"], ["Orange", "Vidor"], ["Travis", "Village of The Hills"], ["Travis", "Villiage of Volente"], ["El Paso", "Vinton"], ["Bexar", "Von Ormy"], ["McLennan", "Waco"], ["Gonzales", "Waelder"], ["Bowie", "Wake Village"], ["Waller", "Waller"], ["Harris", "Waller"], ["Austin", "Wallis"], ["Bosque", "Walnut Springs"], ["Upshur", "Warren City"], ["Gregg", "Warren City"], ["Harrison", "Waskom"], ["Tarrant", "Watauga"], ["Ellis", "Waxahachie"], ["Parker", "Weatherford"], ["Travis", "Webberville"], ["Bastrop", "Webberville"], ["Harris", "Webster"], ["Galveston", "Webster"], ["Colorado", "Weimar"], ["Haskell", "Weinert"], ["Williamson", "Weir"], ["Collingsworth", "Wellington"], ["Terry", "Wellman"], ["Cherokee", "Wells"], ["Hidalgo", "Weslaco"], ["McLennan", "West"], ["Brazoria", "West Columbia"], ["Travis", "West Lake Hills"], ["Orange", "West Orange"], ["Hunt", "West Tawakoni"], ["Harris", "West University Place"], ["Mitchell", "Westbrook"], ["Denton", "Westlake"], ["Tarrant", "Westlake"], ["Collin", "Weston"], ["Fort Bend", "Weston Lakes"], ["Tarrant", "Westover Hills"], ["Tarrant", "Westworth Village"], ["Wharton", "Wharton"], ["Wheeler", "Wheeler"], ["Carson", "White Deer"], ["Gregg", "White Oak"], ["Tarrant", "White Settlement"], ["Cochran", "Whiteface"], ["Hockley", "Whiteface"], ["Smith", "Whitehouse"], ["Grayson", "Whitesboro"], ["Grayson", "Whitewright"], ["Fannin", "Whitewright"], ["Hill", "Whitney"], ["Wichita", "Wichita Falls"], ["Ward", "Wickett"], ["Montgomery", "Willis"], ["Parker", "Willow Park"], ["Van Zandt", "Wills Point"], ["Dallas", "Wilmer"], ["Lynn", "Wilson"], ["Hays", "Wimberley"], ["Bexar", "Windcrest"], ["Fannin", "Windom"], ["Clay", "Windthorst"], ["Archer", "Windthorst"], ["Titus", "Winfield"], ["Winkler", "Wink"], ["Franklin", "Winnsboro"], ["Wood", "Winnsboro"], ["Smith", "Winona"], ["Runnels", "Winters"], ["Brazos", "Wixon Valley"], ["Hunt", "Wolfe City"], ["Lubbock", "Wolfforth"], ["Montgomery", "Woodbranch Village"], ["Hays", "Woodcreek"], ["Montgomery", "Woodloch"], ["Refugio", "Woodsboro"], ["Throckmorton", "Woodson"], ["Tyler", "Woodville"], ["McLennan", "Woodway"], ["Freestone", "Wortham"], ["Limestone", "Wortham"], ["Collin", "Wylie"], ["Rockwall", "Wylie"], ["Dallas", "Wylie"], ["Wood", "Yantis"], ["Lavaca", "Yoakum"], ["DeWitt", "Yoakum"], ["DeWitt", "Yorktown"], ["Angelina", "Zavalla"]];
        var countyList = ["Anderson", "Andrews", "Angelina", "Aransas", "Archer", "Armstrong", "Atascosa", "Austin", "Bailey", "Bandera", "Bastrop", "Baylor", "Bee", "Bell", "Bexar", "Blanco", "Borden", "Bosque", "Bowie", "Brazoria", "Brazos", "Brewster", "Briscoe", "Brooks", "Brown", "Burleson", "Burnet", "Caldwell", "Calhoun", "Callahan", "Cameron", "Camp", "Carson", "Cass", "Castro", "Chambers", "Cherokee", "Childress", "Clay", "Cochran", "Coke", "Coleman", "Collin", "Collingsworth", "Colorado", "Comal", "Comanche", "Concho", "Cooke", "Coryell", "Cottle", "Crane", "Crockett", "Crosby", "Culberson", "Dallam", "Dallas", "Dawson", "Deaf Smith", "Delta", "Denton", "DeWitt", "Dickens", "Dimmit", "Donley", "Duval", "Eastland", "Ector", "Edwards", "El Paso", "Ellis", "Erath", "Falls", "Fannin", "Fayette", "Fisher", "Floyd", "Foard", "Fort Bend", "Franklin", "Freestone", "Frio", "Gaines", "Galveston", "Garza", "Gillespie", "Glasscock", "Goliad", "Gonzales", "Gray", "Grayson", "Gregg", "Grimes", "Guadalupe", "Hale", "Hall", "Hamilton", "Hansford", "Hardeman", "Hardin", "Harris", "Harrison", "Hartley", "Haskell", "Hays", "Hemphill", "Henderson", "Hidalgo", "Hill", "Hockley", "Hood", "Hopkins", "Houston", "Howard", "Hudspeth", "Hunt", "Hutchinson", "Irion", "Jack", "Jackson", "Jasper", "Jeff Davis", "Jefferson", "Jim Hogg", "Jim Wells", "Johnson", "Jones", "Karnes", "Kaufman", "Kendall", "Kenedy", "Kent", "Kerr", "Kimble", "King", "Kinney", "Kleberg", "Knox", "La Salle", "Lamar", "Lamb", "Lampasas", "Lavaca", "Lee", "Leon", "Liberty", "Limestone", "Lipscomb", "Live Oak", "Llano", "Loving", "Lubbock", "Lynn", "Madison", "Marion", "Martin", "Mason", "Matagorda", "Maverick", "McCulloch", "McLennan", "McMullen", "Medina", "Menard", "Midland", "Milam", "Mills", "Mitchell", "Montague", "Montgomery", "Moore", "Morris", "Motley", "Nacogdoches", "Navarro", "Newton", "Nolan", "Nueces", "Ochiltree", "Oldham", "Orange", "Palo Pinto", "Panola", "Parker", "Parmer", "Pecos", "Polk", "Potter", "Presidio", "Rains", "Randall", "Reagan", "Real", "Red River", "Reeves", "Refugio", "Roberts", "Robertson", "Rockwall", "Runnels", "Rusk", "Sabine", "San Augustine", "San Jacinto", "San Patricio", "San Saba", "Schleicher", "Scurry", "Shackelford", "Shelby", "Sherman", "Smith", "Somervell", "Starr", "Stephens", "Sterling", "Stonewall", "Sutton", "Swisher", "Tarrant", "Taylor", "Terrell", "Terry", "Throckmorton", "Titus", "Tom Green", "Travis", "Trinity", "Tyler", "Upshur", "Upton", "Uvalde", "Val Verde", "Van Zandt", "Victoria", "Walker", "Waller", "Ward", "Washington", "Webb", "Wharton", "Wheeler", "Wichita", "Wilbarger", "Willacy", "Williamson", "Wilson", "Winkler", "Wise", "Wood", "Yoakum", "Young", "Zapata", "Zavala"];
       
        function sortOrderCounty(co) {
            for (var i = 0; i < countyList.length; i++) {
                if (co == countyList[i]) {
                    document.getElementById('sortCountyOrder').value = i;
                    if (document.getElementById('jurisdictionType1').checked == false) {
                        document.getElementById('sortCityOrder').value = "";
                    }
                    return;
                }
            }
        }
        function sortOrderCity(ci) {
            var co = "";
            var a = document.getElementById('county');
            if (a.selectedIndex != 0) {
                co = a.options[a.selectedIndex].text;
            }

            for (var i = 0; i < cityMatrix.length; i++) {
                if (ci == cityMatrix[i][1] && document.getElementById('jurisdictionType1').checked==true && (co=="" || co == cityMatrix[i][0])){
                    document.getElementById('sortCityOrder').value = i;
                    return;
                }
                if (ci == cityMatrix[i][1] && document.getElementById('jurisdictionType1').checked==false) {
                    document.getElementById('sortCityOrder').value = i;
                    return;
                }
            }
        }

        function rebuildingCityCountyOptionsOnJTypeCheck(a) {
            $(a).on("click", function () {
                var coList = document.getElementById("county");
                removeOptions(coList);
                addOption(coList, 'Select One', true);
                for (var k = 0; k < countyList.length; k++) {
                    addOption(coList, countyList[k], false);
                }
                var cityList = document.getElementById("city");
                removeOptions(cityList);
                addOption(cityList, "Select One", true);
                addOption(cityList, "Unincorporated Areas", false);
                for (var k = 0; k < cityMatrix.length; k++) {
                    addOption(cityList, cityMatrix[k][1], false);
                }
                $("#sortCountyOrder").val(0);
                $("#sortCityOrder").val(0);
                $("#submitedDateTime").val(0);
                $("#county").prop("disabled", false);
                $("#city").prop("disabled", false);
            });
        }

        function start() {
            //document.forms[0].onsubmit = submit;
            $("#saveCmd").on("click", function () { submit(); });
            rebuildingCityCountyOptionsOnJTypeCheck("#jurisdictionType1");
            rebuildingCityCountyOptionsOnJTypeCheck("#jurisdictionType2");
            initPopUp();
            autoSum();
            document.getElementById('city').onchange = function () {
                sortOrderCity(this.options[this.selectedIndex].text);
                var coList = document.getElementById("county");
                var coSelected = coList.options[coList.selectedIndex].text;
                if (this.options[this.selectedIndex].text == 'Select One') {
                    removeOptions(coList);
                    addOption(coList, 'Select One', true);
                    for (var k = 0; k < countyList.length; k++) {
                        addOption(coList, countyList[k], false);
                    }
                    // sortSelect(this);
                } else if (this.options[this.selectedIndex].text == 'Unincorporated Areas') { } else {
                    removeOptions(coList);
                    addOption(coList, 'Select One', false);
                    for (var k = 0; k < cityMatrix.length; k++) {
                        if (cityMatrix[k][1] === this.options[this.selectedIndex].text) {
                            var selected = false;
                            if (cityMatrix[k][0] == coSelected) { selected = true; }
                            addOption(coList, cityMatrix[k][0], selected);
                        }
                    }
                }


            }

            document.getElementById('county').onchange = function () {
                sortOrderCounty(this.options[this.selectedIndex].text);
                var cityList = document.getElementById("city");
                if (this.options[this.selectedIndex].text == 'Select One') {
                    removeOptions(cityList);
                    addOption(cityList, "Select One", false);
                    addOption(cityList, "Unincorporated Areas", true);
                    for (var k = 0; k < cityMatrix.length; k++) {
                        addOption(cityList, cityMatrix[k][1], false);
                    }
                    // sortSelect(this);
                }
                else {
                    removeOptions(cityList);
                    addOption(cityList, "Select One", false);
                    addOption(cityList, "Unincorporated Areas", true);
                    for (var k = 0; k < cityMatrix.length; k++) {

                        if (cityMatrix[k][0] === this.options[this.selectedIndex].text) {
                            addOption(cityList, cityMatrix[k][1], false);
                        }
                    }
                }
            }
            $('.datepicker').datepicker();
            var jType = document.getElementsByName('jurisdictionType');
            if (jType[1].checked === true) { document.getElementById('countyEmailSection').style.display = "none"; }
            var jTypeFunction = function () {
               
                var a = document.getElementsByName('jurisdictionType');
                var b = document.getElementById('city');
                var c = document.getElementById('countyEmailSection');
                for (var i = 0; i < a.length; i++) {
                    if (a[i].checked === true) {
                        if (a[i].id === 'jurisdictionType1') {//If City
                            b.multiple = false;
                            //c.style.display = ""; //WILL UNCOMMENT LATER
                            return;
                        }
                        if (a[i].id === 'jurisdictionType2') {//if county
                            b.multiple = true;
                            //c.style.display = "none"; //WILL UNCOMMENT LATER
                            return;
                        }
                    }
                }
            };
            jType[0].onclick = jTypeFunction; jType[1].onclick = jTypeFunction;
            $('#resLosses input').click(function () {
                var a = document.getElementById('resLosses')
                for (var i = 1; i < a.rows.length - 1; i++) {
                    var b = a.rows[i].getElementsByTagName('input'); 
                    if (b[0].value != '' || b[1].value != '' || b[2].value != '' || b[3].value != '') {
                       // $(b[4]).parent().addClass('required');
                    }
                }
            });

            $('#resLosses input').click(function () {
                var a = document.getElementById('busLosses');
                for (var i = 1; i < a.rows.length - 1; i++) {
                    var b = a.rows[i].getElementsByTagName('input');
                    if (b[0].value != '' || b[1].value != '' || b[2].value != '') {
                      //  $("input", a.rows[i]).parent().addClass('required');
                    }
                }
            });
  
            commandInfoWindow('multiFamilyUnitInfo', 'Single Family/Multi-Family Homes', '<div>Single Family/Multi-Family Homes (All variable – depends on length of time structure was flooded, velocity, clean/dirty flood water, etc.)<ol><li>Affected 0-6 inches</li><li>Minor 6-18 inches (Electrical, insulation)</li><li>Major 18-48 inches</li><li>Over 48 inches – requires further investigation</li><li>Destroyed</li></ol></div>');
            commandInfoWindow('singleFamilyHomeInfo','Single Family/Multi-Family Homes', '<div>Single Family/Multi-Family Homes (All variable – depends on length of time structure was flooded, velocity, clean/dirty flood water, etc.)<ol><li>Affected 0-6 inches</li><li>Minor 6-18 inches (Electrical, insulation)</li><li>Major 18-48 inches</li><li>Over 48 inches – requires further investigation</li><li>Destroyed</li></ol></div>');
            commandInfoWindow('mobileHomesInfo', 'Mobile Homes', '<div>Affected - Ground level to within 12 inches of bottom board<ol><li>Minor – Within 12 inches of bottom board to 3 inches above floor level</li><li>Major 3-12 inches above floor level</li><li>Over 12 inches – requires further investigation</li><li>Destroyed</li></ol></div>');
            commandInfoWindow('affectedSpan', 'Affected', '<div>If the living unit, porch, carport, garage, etc., was damaged but in the inspector’s judgment the living unit is still habitable, the Affected category should be used.</div>');
            commandInfoWindow('minorDamageSpan', 'Minor Damage', '<div>Minor damage is when the home is damaged and uninhabitable, but may be made habitable in a short period of timewith home repairs. Any one of the following may constitute minor damage:<ol><li>Can be repaired within 30 days</li><li>Has more than $100 (or more than program minimum) of eligible habitability items and has less than $10,000 (or less than program maximum) of eligible habitability items under the Disaster Housing Program, Home Repair Grant</li><li>Has less than 50% damage to structure</li></ol></div>');
            commandInfoWindow('majorDamageSpan', 'Major Damage', '<div>Major damage is when the home has sustained structural or significant damages, is uninhabitable and requires extensive repairs. Any one of the following may constitute major damage.<ol><li>Substantial failures to structural elements of the residence (e.g., walls, floors, foundation)</li><li>Damage to the structure that exceeds the Disaster Housing Program Home Repair Grant maximum ($10,000)</li><li>General exterior property damage that exceeds the Disaster Housing Program Home Repair Grant maximum (e.g., roads and bridges, wells, earth movement, and other imminent danger situations.)</li><li>Has more than 50% damage to structure</li><li>Damage that will take more than 30 days to repair</li></ol></div>');
            commandInfoWindow('destroyedSpan', 'Destroyed', '<div>Destroyed is used when there is a total loss or damage to such an extent that repairs are not economically feasible. Any one of the following may constitute a status of destroyed: (Should be obvious)<ol><li>Structure is not economically feasible to repair</li><li>Structure is permanently uninhabitable</li><li>Complete failures to major components of structure (e.g., foundation, walls, roof)</li><li>Unaffected structure that will require demolition as a result of the disaster (e.g., floodplain)</li></ol></div>');
            commandInfoWindow('insuranceSpan', 'Estimating Insurance', '<div>The following are general guidelines to estimating insurance coverage.<ol><li>Renters are less likely to have insurance</li><li>Low income residents are less likely to have insurance</li><li>Homeowners who are still paying off their mortgage normally have the appropriate type of insurance</li><li>Residents who are flooded and reside in an area that does not participate in the NFIP or in an area that has been sanctioned for NFIP code enforcement violations will not have flood insurance</li><li>Residents who are flooded but whose property is not located in the Special Flood Hazard Area (SFHA) will probably not have flood insurance.</li></ol></div>');
            commandInfoWindow('businessesEconomicInjuryInfo', 'Business Economic Injury', '<div>SBA makes an economic injury declaration in reliance on a state certification that at least five small business concerns in a disaster area have suffered substantial economic injury as a result of the disaster and are in need of financial assistance not otherwise available on reasonable terms.<ul><li>Does not cover lost income</li><li>Businesses claiming the loss would have to provide financials and accounting records to prove the loss</li><li>Businesses compensated with insurance would have to prove their injury is substantial after insurance claims are paid</li></ul></div>')
            commandInfoWindow('emergencyProtectiveMeasuresInfo', 'Emergency Protective Measures', '<div>Includes response costs, protection of life &amp; property, and then temporary repairs as examples</div>');
            commandInfoWindow('buildingEquipmentInfo', 'Building & Equipment', '<div>Also includes vehicles and contents of buildings</div>');
            commandInfoWindow('cityInfo', 'City Options', '<div><ul><li>Multiple cities can be selected when reporting for the County by holding down the Ctrl whild clicking on the city names.</li><li>Only a single city is allowed to be selected when filling the DSO out for a City</li></ul></div>');
            commandInfoWindow('catAInfo','Category A: Debris Removal','<div>Clearance of trees and woody debris; certain building wreckage; damaged/ destroyed building contents; sand, mud, silt, and gravel; vehicles; and other disaster-related material deposited on public and, in very limited cases, private property.</div>');
            commandInfoWindow('catBInfo','Category B: Emergency Protective Measures','<div>Measures taken before, during, and after a disaster to eliminate/reduce an immediate threat to life, public health, or safety, or to eliminate/reduce an immediate threat of significant damage to improved public and private property through cost-effective measures.</div>');
            commandInfoWindow('catCInfo','Category C: Roads and Bridges','<div>Repair of roads, bridges, and associated features, such as shoulders, ditches, culverts, lighting, and signs.</div>');
            commandInfoWindow('catDInfo','Category D: Water Control Facilities','<div>Repair of drainage channels, pumping facilities, and some irrigation facilities. Repair of levees, dams, and flood control channels fall under Category D, but the eligibility of these facilities is restricted.</div>');
            commandInfoWindow('catEInfo','Category E: Buildings and Equipment','<div>Repair or replacement of buildings, including their contents and systems; heavy equipment; and vehicles.</div>');
            commandInfoWindow('catFInfo','Category F: Utilities','<div>Repair of water treatment and delivery systems; power generation facilities and distribution facilities; sewage collection and treatment facilities; and communications.</div>');
            commandInfoWindow('catGInfo', 'Category G: Parks, Recreational Facilities, and Other Facilities', '<div>Repair and restoration of parks, playgrounds, pools, cemeteries, mass transit facilities, and beaches. This category also is used for any work or facility that cannot be characterized adequately by Categories A-F.</div>');
            commandInfoWindow('additionalEmailsInfo', 'Additional Emails', '<div>Separate all email address with a Comma (,)</div>');
            setDynamicValidationEventsLogic();
            scribe.fields4History = [
                      ["webeocIncident", "WebEOC Incident"],
            ["county", "County"],
            ["city", "City"],
            ["type", "Incident Type"],
            ["cat01", "Other Category Type 01"],
            ["cat02", "Other Category Type 02"],
            ["cat03", "Other Category Type 03"],
            ["cat04", "Other Category Type 04"],
            ["cat05", "Other Category Type 05"],
            ["cat06", "Other Category Type 06"],
            ["cat07", "Other Category Type 07"],
            ["cat08", "Other Category Type 08"],
            ["cat09", "Other Category Type 09"],
            ["cat10", "Other Category Type 10"],
            ["cat11", "Other Category Type 11"],
            ["cat12", "Other Category Type 12"],
            ["cat13", "Other Category Type 13"],
            ["cat14", "Other Category Type 14"],
            ["cat15", "Other Category Type 15"],
            ["jurisdictionType", "Jurisdiction Type"],
            ["population", "Populatioin"],
            ["nfip", "NFIP"],
            ["dateOfDisaster1", "State Date of Disaster"],
            ["dateOfDisaster2", "End Date of Disaster"],
            ["continuing", "Disaster Continuing"],
            ["declarationIssued", "Declaration Declared"],
            ["contactPerson", "Contact Person"],
            ["contactPersonTitle", "Contact Person Title"],
            ["address", "Address"],
            ["phone", "Phone"],
            ["mobilePhone", "Mobile Phone"],
            ["fax", "Fax"],
            ["pager", "Pager"],
            ["dutyPhone", "Duty Phone"],
            ["sfhAffected", "Single Faimly Homes Affected"],
            ["sfhMinorDamage", "Single Faimly Homes Minor"],
            ["sfhMajorDamage", "Single Faimly Homes Major"],
            ["sfhDestroyed", "Single Faimly Homes Destroyed"],
            ["sfhCovByInsurance", "Single Faimly Home Insured"],
            ["mhAffected", "Mobile Homes Affected"],
            ["mhMinorDamage", "Mobile Homes Minor "],
            ["mhMajorDamage", "Mobile Homes Major"],
            ["mhDestroyed", "Mobile Homes Destroyed"],
            ["mhCovByInsurance", "Mobile Home Insured"],
            ["mfuAffected", "Multi-Family Units Affected"],
            ["mfuMinorDamage", "Multi-Family Units Minor"],
            ["mfuMajorDamage", "Multi-Family Units  Major"],
            ["mfuDestroyed", "Multi-Family Units Insurance"],
            ["mfuCovByInsurance", "Multi-Family Units Affected"],
            ["totalsAffected", "Total Residental Affected"],
            ["totalsMinorDamage", "Total Residental Minor"],
            ["totalsMajorDamage", "Total Residental Major"],
            ["totalsDestroyed", "Total Residental Destroyed"],
            ["totalsCovByInsurance", "Total Residental Insured"],
            ["homesIsolated", "Homes Isolated"],
            ["numberMinorDamage", "Business Minor Damage"],
            ["coveredMinorDamage", "Business Minor Insured"],
            ["totalMinorDamage", "Business Minor Repair $"],
            ["numberMajorDamage", "Business Major Damage"],
            ["coveredMajorDamage", "Business Major Insured"],
            ["totalMajorDamage", "Business Major Repair $"],
            ["numberTotal", "Business Damaged"],
            ["coveredTotal", "Business Insured"],
            ["totalTotal", "Business Repair $"],
            ["businessesCeased", "Businesses Ceased Operations"],
            ["businessesEconomicInjury", "Nusinessess Economic Injury"],
            ["numberUnemployed", "Number Unemployed"],
            ["sitesDebrisClearance", "CAT A Sites"],
            ["repairCostDebrisClearance", "CAT A Estimated Cost"],
            ["insuranceDebrisClearance", "CAT A Insured"],
            ["sitesEmergency", "CAT B Sites"],
            ["repairCostEmergency", "CAT B Estimated Cost"],
            ["insuranceEmergency", "CAT B Insured"],
            ["sitesRoadPaved", "CAT C Sites"],
            ["repairCostRoadPaved", "CAT C Estimated Cost"],
            ["insuranceRoadPaved", "CAT C Insured"],
            ["sitesWaterControlFacilities", "CAT D Sites"],
            ["repairCostWaterControlFacilities", "CAT D Estimated Cost"],
            ["insuranceWaterControlFacilities", "CAT D Insured"],
            ["sitesBuildingsEquipment", "CAT E Sites"],
            ["repairCostBuildingsEquipment", "CAT E Estimated Cost"],
            ["insuranceBuildingsEquipment", "CAT E Insured"],
            ["sitesUtilitySystems", "CAT F Sites"],
            ["repairCostUtilitySystems", "CAT F Estimated Cost"],
            ["insuranceUtilitySystems", "CAT F Insured"],
            ["sitesOther", "CAT G Sites"],
            ["repairCostOther", "CAT G Estimated Cost"],
            ["insuranceOther", "CAT G Insured"],
            ["sitesTotals", "CAT Site Total"],
            ["repairCostTotals", "CAT Cost Total"],
            ["insuranceTotals", "CAT Insured Total"],
            ["annualMaintenanceBudget", "Annual Maintenace Budget"],
            ["startOfFiscalYear", "Start of Fiscal Year"],
            ["orgFacility01", "Other Facility 01"],
            ["sites01", "Other Sites 01"],
            ["repairCost01", "Other Repair Cost 01"],
            ["insurance01", "Other Insured 01"],
            ["orgFacility02", "Other Facility 02"],
            ["sites02", "Other Sites 02"],
            ["repairCost02", "Other Repair Cost 02"],
            ["insurance02", "Other Insured 02"],
            ["orgFacility03", "Other Facility 03"],
            ["sites03", "Other Sites 03"],
            ["repairCost03", "Other Repair Cost 03"],
            ["insurance03", "Other Insured 03"],
            ["orgFacility04", "Other Facility 04"],
            ["sites04", "Other Sites 04"],
            ["repairCost04", "Other Repair Cost 04"],
            ["insurance04", "Other Insured 04"],
            ["orgFacility05", "Other Facility 05"],
            ["sites05", "Other Sites 05"],
            ["repairCost05", "Other Repair Cost 05"],
            ["insurance05", "Other Insured 05"],
            ["orgFacility06", "Other Facility 06"],
            ["sites06", "Other Sites 06"],
            ["repairCost06", "Other Repair Cost 06"],
            ["insurance06", "Other Insured 06"],
            ["orgFacility07", "Other Facility 07"],
            ["sites07", "Other Sites 07"],
            ["repairCost07", "Other Repair Cost 07"],
            ["insurance07", "Other Insured 07"],
            ["orgFacility08", "Other Facility 08"],
            ["sites08", "Other Sites 08"],
            ["repairCost08", "Other Repair Cost 08"],
            ["insurance08", "Other Insured 08"],
            ["orgFacility09", "Other Facility 09"],
            ["sites09", "Other Sites 09"],
            ["repairCost09", "Other Repair Cost 09"],
            ["insurance09", "Other Insured 09"],
            ["orgFacility10", "Other Facility 10"],
            ["sites10", "Other Sites 10"],
            ["repairCost10", "Other Repair Cost 10"],
            ["insurance10", "Other Insured 10"],
            ["orgFacility11", "Other Facility 11"],
            ["sites11", "Other Sites 11"],
            ["repairCost11", "Other Repair Cost 11"],
            ["insurance11", "Other Insured 11"],
            ["orgFacility12", "Other Facility 12"],
            ["sites12", "Other Sites 12"],
            ["repairCost12", "Other Repair Cost 12"],
            ["insurance12", "Other Insured 12"],
            ["orgFacility13", "Other Facility 13"],
            ["sites13", "Other Sites 13"],
            ["repairCost13", "Other Repair Cost 13"],
            ["insurance13", "Other Insured 13"],
            ["orgFacility14", "Other Facility 14"],
            ["sites14", "Other Sites 14"],
            ["repairCost14", "Other Repair Cost 14"],
            ["insurance14", "Other Insured 14"],
            ["orgFacility15", "Other Facility 15"],
            ["sites15", "Other Sites 15"],
            ["repairCost15", "Other Repair Cost 15"],
            ["insurance15", "Other Insured 15"],
            ["sitesOtherTotal", "Other Sites Total"],
            ["repairCostTotal", "Other Repair Cost Total"],
            ["insuranceCostTotal", "Other Insured Total"],
            ["submitterName", "Submitter Name"],
            ["submitterEmail", "Submitter Email"],
            ["countyEmail", "County Email"],
            ["ddcEmail", "DDC Email"],
            ["additionalEmails", "Additional Emails"],
            ["notes", "Notes"]
            ];
            scribe.inicialReview();
            $("#county").prop("disabled", true);
            $("#city").prop("disabled", true);
            if ($("#jurisdictionType1").is(":checked") || $("#jurisdictionType2").is(":checked")) {
                $("#county").prop("disabled", false);
                $("#city").prop("disabled", false);
            }
        }
       
        function setDynamicValidationEventsLogic() {
           /* $('#type').change(function () { //nfip required.
                if ($("#type option:selected").text() == 'Flooding') {
                    $("#nfipDiv").addClass('required');
                }
                else {
                    $("#nfipDiv").removeClass('required');
                }
            });*/
            $("input[name='sheltersOpen']").click(function () {
              
                if (this.id == 'sheltersOpen1') {
                    $("#sheltersHowManyDiv").addClass('required');
                } else {
                    $("#sheltersHowManyDiv").removeClass('required');
                }
            })

        }
        function CheckFields(){
            var errors = 0;
            $(".required").each(function() {
                $(this).removeClass('has-error has-success');

                var a = this.getElementsByTagName('input');
                if (a.length > 0) {
                    if (a[0].type == 'text') {
                        if ($("input[type='text']", this).val() === '') {
                            $(this).addClass('has-error');
                            errors++;
                        } else {
                            $(this).addClass('has-success');
                        }

                    }
                    if (a[0].type == 'radio') {
                        if (!$("input[type='radio']:checked", this).val()) {
                            $(this).addClass('has-error');
                            errors++;
                        } else {
                            $(this).addClass('has-success');
                        }
                    }
                }
                a = this.getElementsByTagName('select');
                if (a.length > 0) {
                    if(a[0].selectedIndex==-1 || a[0].options[a[0].selectedIndex].text == 'Select One')
                    {
                        $(this).addClass('has-error');
                        errors++;
                    } else {
                        $(this).addClass('has-success');
                    }
		
                }
            });
            if (errors != 0) {
                runError();
                return false;
            }else{return true;}
           
        }
        /*
        var scribe = { 
            status: 0,
            autoRun: function () { },
            baseArray: [],
            changesMade: false,
            Evaluation: function () {
                var a = [];
                for (var i = 0; i < scribe.fields4History.length; i++) {
                    var b = document.getElementsByName(scribe.fields4History[i][0]);
                    for (var k = 0; k < b.length; k++) {
                        var result = [];
                        if (b[k].tagName === "SELECT") {
                            result.push(scribe.fields4History[i][1]);
                            result.push(b[k].options[b[k].selectedIndex].text);
                        } else if (b[k].type === "radio" || b[k].type === "checkbox") {
                            result.push(scribe.fields4History[i][1]);
                            if (b[k].checked === true) {
                                result.push('Selected');
                            } else {
                                result.push('Not Selected');
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
            inicialReview: function () {
                scribe.baseArray = scribe.Evaluation();
            },
            postReview: function () {
                var p = [];
                var f = scribe.Evaluation();
                for (var i = 0; i < f.length; i++) {
                    if (f[i][1] !== scribe.baseArray[i][1]) {
                        p.push(f[i][0] + ': ' + f[i][1]);
                    }
                }
                p = p.join('\r\n');
                if (p.length > 0) { scribe.changesMade = true; }
                return p;
            }
        };*/
        var scribe = { 
            status: 0,
            autoRun: function () { },
            baseArray: [],
            changesMade: false,
            Evaluation: function() {
                var a=[];
                for(var i=0; i < scribe.fields4History.length; i++) {
                    var b=document.getElementsByName(scribe.fields4History[i][0]);
                    for(var k=0; k < b.length; k++) {
                        //console.log(b[k]);
                        var result=[];
                        if(b[k].tagName==="SELECT") {
                            var ms = b[k].selectedOptions;
                            var msr =[];
                            //console.log("ms below");
                            //console.log(ms);
                            for(var msi=0; msi < ms.length; ms++){
                                msr.push(ms[msi].text);
                            }
                            result.push(scribe.fields4History[i][1]);
                            result.push(msr.join(','));   
                        } else if (b[k].type==="radio" || b[k].type==="checkbox") {
                            result.push(scribe.fields4History[i][1]);
                            if(b[k].checked===true) {
                                result.push('Selected');
                            } else {
                                result.push('Not Selected');
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
            inicialReview: function () {
                scribe.baseArray = scribe.Evaluation();
            },
            postReview: function () {
                var p = [];
                var f = scribe.Evaluation();
                for (var i = 0; i < f.length; i++) {
                    if (f[i][1] !== scribe.baseArray[i][1]) {
                        p.push(f[i][0] + ': ' + f[i][1]);
                    }
                }
                p = p.join('\r\n');
                if (p.length > 0) { scribe.changesMade = true; }
                return p;
            }
        };

        function validateEmail(email) {
            var str = email.replace(/\s/g, '');
            var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            return re.test(str);
        }
        function finalEmailCheck() {
            var checkEmail = function (a) {
                for (var i = 0; i < a.length; i++) {
                    if (a[i] != '' && validateEmail(a[i]) == false) {
                        return false;
                    }
                }
            };
            if(validateEmail(document.getElementById('submitterEmail').value) == false){
                return false;
            }
            var b = 
            checkEmail();
            checkEmail(document.getElementById('countyEmail').value.split(','));
            checkEmail(document.getElementById('ddcEmail').value.split(','));

        }
        function submit() {
            if (finalEmailCheck() == false) {
                BootstrapDialog.show({
                    title: "Warning!",
                    message: function (dialog) {
                        var $content = $("<div>Please check your email format.</div>");
                        return $content;
                    },
               });
                event.preventDefault();
                //return false;
            }
            document.getElementById('audit').value = scribe.postReview();
            if (cancel == false) {
                var a = CheckFields();
                /*var n = document.getElementsByClassName('number');
                for (var i = 0; i < n.length; i++) {
                    if (n[i].value != '') {
                        n[i].value = removeNonNumber(n[i].value);
                    }
                }*/
                if (a == false) {
                    return false;
                } else { return true; }
               
            }
            
        }

        Object.defineProperty(HTMLSelectElement.prototype, "selectedOptions", {
            get: (function() {
                try {
                    document.querySelector(":checked");
                    return function() {
                        return this.querySelectorAll(":checked");
                    };
                } catch (e) {
                    return function() {
                        if (!this.multiple) {
                            return this.selectedIndex > 0
                            ? [this.options[this.selectedIndex]] : [];
                        }
                        for (var i = 0, a = []; i < this.options.length; i++)
                        if (this.options[i].selected) a.push(this.options[i]);
                        return a;
                    };
                }
            })()
        });

        window.onload = start;
    </script>
</head>
<body>
    <form id="form1" runat="server" role="form" >
        <div id="hidden" style="display:none">
             <div class="form-group form-inline">
      <label class="control-label" for="sortCountyOrder">Sort County Order:</label>
         <asp:TextBox ID="sortCountyOrder" CssClass="form-control input-sm" Text="0" runat="server"></asp:TextBox>
    </div>
            <div class="form-group form-inline">
      <label class="control-label" for="sortCityOrder">Sort City Order:</label>
         <asp:TextBox ID="sortCityOrder" CssClass="form-control input-sm" Text="0" runat="server"></asp:TextBox>
       
    </div>
            <div class="form-group form-inline">
      <label class="control-label" for="submitedDateTime">Submited DateTime:</label>
         <asp:TextBox ID="submitedDateTime" CssClass="form-control input-sm" Text="0" runat="server"></asp:TextBox>
    </div>
        </div>
        <div id="container">
            <h1> <span class="label label-default" runat="server" id="entryType"></span></h1>
             <h1> <span class="label label-default">Incident</span></h1>
             <br/>
            <div class="form-group form-inline">
      <label class="control-label" for="webeocIncident">Incident:</label>
        <asp:DropDownList ID="webeocIncident" name="webeocIncident" runat="server" CssClass="form-control">
        </asp:DropDownList>
    </div>


       <h1> <span class="label label-default">General</span></h1>
       <br/>
    <div class="form-group required form-inline">
      <label class="control-label" for="jurisdictionType">Jurisdiction Type:</label>
        <asp:RadioButton ID="jurisdictionType1" CssClass="form-control input-sm" GroupName="jurisdictionType" runat="server" Text="City" />
        <asp:RadioButton ID="jurisdictionType2" CssClass="form-control input-sm" GroupName="jurisdictionType" runat="server" Text="County" />
    </div>
    <div class="form-group required form-inline">
      <label class="control-label" for="county">County:</label>
        <asp:DropDownList ID="county" name="county" runat="server" CssClass="form-control">
        </asp:DropDownList>
       
    </div>

   <div class="form-group required form-inline">
      <label class="control-label" for="city">Areas Also Included:</label> <span id="cityInfo" class="label label-info">i</span>
        <!--<asp:DropDownList ID="city3" name="city" runat="server" CssClass="form-control"></asp:DropDownList>-->
     <asp:ListBox ID="city" runat="server" CssClass="form-control" SelectionMode="Multiple"></asp:ListBox>
       
    </div>
            <div class="form-group form-inline">
      <label class="control-label" for="population">Population:</label>
        <asp:TextBox ID="population" CssClass="form-control input-sm" runat="server"></asp:TextBox>
       
    </div>
      <div class="form-group form-inline">
      <label class="control-label" for="type" >Type: </label><asp:ListBox ID="type" SelectionMode="Multiple" runat="server"  CssClass="form-control"></asp:ListBox>
        <!--<asp:TextBox ID="type2" CssClass="form-control input-sm" runat="server"></asp:TextBox>-->
    </div>  
     <div class="form-group form-inline" id="nfipDiv">
      <label class="control-label" for="nfip">If this is a flood event, does the City/County participate in the National Flood Insurance Program (NFIP)?:</label>
        <asp:RadioButton ID="nfip1" CssClass="form-control input-sm" GroupName="nfip" runat="server" Text="Yes" />
        <asp:RadioButton ID="nfip2" CssClass="form-control input-sm" GroupName="nfip" runat="server" Text="No" />
    </div>
     <div class="form-group form-inline">
      <label class="control-label" for="dateOfDisaster">Inclusive dates of the disaster:</label>
        <asp:TextBox ID="dateOfDisaster1" placeholder="Start Date" data-provide="datepicker" CssClass="form-control input-sm datepicker" runat="server"></asp:TextBox> - <asp:TextBox data-provide="datepicker" ID="dateOfDisaster2" placeholder="End Date" CssClass="form-control input-sm datepicker" runat="server"></asp:TextBox>
         <span>  <asp:CheckBox ID="continuing" runat="server" Text="Continuing"  /></span>

    </div>      
 <div class="form-group form-inline">
      <label class="control-label" for="declarationIssued">Was a local disaster declaration issued?:</label>
        <asp:RadioButton ID="declarationIssued1" CssClass="form-control input-sm" GroupName="declarationIssued" runat="server" Text="Yes" />
        <asp:RadioButton ID="declarationIssued2" CssClass="form-control input-sm" GroupName="declarationIssued" runat="server" Text="No" />
    </div>
   <div class="form-group required form-inline">
      <label class="control-label" for="contactPerson">Contact Person:</label>
        <asp:TextBox ID="contactPerson" CssClass="form-control input-sm" runat="server"></asp:TextBox>
    </div>
             <div class="form-group required form-inline">
      <label class="control-label" for="contactPersonTitle">Title:</label>
        <asp:TextBox ID="contactPersonTitle" CssClass="form-control input-sm" runat="server"></asp:TextBox>
    </div>                
   <div class="form-group form-inline">
      <label class="control-label" for="address">Address:</label>
        <asp:TextBox ID="address" CssClass="form-control input-sm" runat="server"></asp:TextBox>
    </div>  
   <div class="form-group required form-inline">
      <label class="control-label" for="phone">Phone:</label>
        <asp:TextBox ID="phone" CssClass="form-control input-sm" runat="server"></asp:TextBox>
    </div> 
             <div class="form-group form-inline">
      <label class="control-label" for="mobilePhone">Mobile Phone:</label>
        <asp:TextBox ID="mobilePhone" CssClass="form-control input-sm" runat="server"></asp:TextBox>
    </div> 
    <div class="form-group form-inline">
      <label class="control-label" for="fax">Fax:</label>
        <asp:TextBox ID="fax" CssClass="form-control input-sm" runat="server"></asp:TextBox>
    </div>
  <div class="form-group form-inline">
      <label class="control-label" for="pager">Pager:</label>
        <asp:TextBox ID="pager" CssClass="form-control input-sm" runat="server"></asp:TextBox>
    </div>
   <div class="form-group form-inline">
      <label class="control-label" for="dutyPhone">24-Hr Duty Officer/Sheriff's Office:</label>
       <asp:TextBox ID="dutyPhone" CssClass="form-control input-sm" runat="server"></asp:TextBox>
    </div>
    <br/>
  <!-- <h1><span class="label label-default"> Individual Assistance</span></h1>
       <h3><span class="label label-default"> Casualties:</span></h3>                   
 <div class="form-group required form-inline">
      <label class="control-label"  for="fatalities">Number of Fatalities:</label>
       <asp:TextBox ID="fatalities" Text="0" CssClass="form-control input-sm" runat="server"></asp:TextBox>
    </div>        
  <div class="form-group required form-inline">
      <label class="control-label" for="injuries">Number of Injuries:</label>
       <asp:TextBox ID="injuries" Text="0" CssClass="form-control input-sm" runat="server"></asp:TextBox>
    </div>
          <div class="form-group  required form-inline">
      <label class="control-label" for="hospitalized">Number of Hospitalized:</label>
       <asp:TextBox ID="hospitalized" Text="0" CssClass="form-control input-sm" runat="server"></asp:TextBox>
    </div>  
            <br />-->
               
            
       <!--                
<h3><span class="label label-default">Agricultural Losses:</span>
</h3>
            <h4><i>Contact the Farm Service Agency in your county</i></h4>
<div class="form-group form-inline">
      <label class="control-label" for="agricultural">Is agricultural assistance needed?:</label>
        <asp:RadioButton ID="agricultural1" CssClass="form-control input-sm" GroupName="declarationIssued" runat="server" Text="Yes" />
        <asp:RadioButton ID="agricultural2" CssClass="form-control input-sm" GroupName="declarationIssued" runat="server" Text="No" />
<br />
    <i> If yes, please attach USDA flash situation report.</i>    
</div>
            <div class="form-group form-inline">
      <label class="control-label" for="usdaFlashReport">USDA Flash Report:</label>
                <asp:FileUpload ID="usdaFlashReport" runat="server" />
</div>
            -->
            <!--PO added 081916-->
 <h1><span class="label label-default">Individual Assistance</span></h1><!--PO added 081916-->
  <h3><span class="label label-default">  Residential Losses - Primary Residence Only</span></h3>
<br/>
    <table id="resLosses" class="table table-bordered">
    <tr>
    <td>Type of Homes</td>
    <td>Affected <span id="affectedSpan" class="label label-info">i</span></td>
    <td>Minor Damage <span id="minorDamageSpan" class="label label-info">i</span></td>
    <td>Major Damage <span id="majorDamageSpan" class="label label-info">i</span></td>
    <td>Destroyed <span id="destroyedSpan" class="label label-info">i</span></td>
    <td>% Covered by Insurance <span id="insuranceSpan" class="label label-info">i</span></td>
    </tr>
    <tr>
      <td>Single Family Homes <span id="singleFamilyHomeInfo" class="label label-info">i</span></td>
      <td> <div class="form-group form-inline"> <asp:TextBox ID="sfhAffected" placeholder="0" CssClass="form-control input-sm totalsAffected number" runat="server"></asp:TextBox></div></td>
      <td> <div class="form-group form-inline"> <asp:TextBox ID="sfhMinorDamage" placeholder="0" CssClass="form-control input-sm totalsMinorDamage number" runat="server"></asp:TextBox></div></td>
      <td> <div class="form-group form-inline"> <asp:TextBox ID="sfhMajorDamage" placeholder="0" CssClass="form-control input-sm totalsMajorDamage number" runat="server"></asp:TextBox></div></td>
      <td> <div class="form-group form-inline"> <asp:TextBox ID="sfhDestroyed" placeholder="0" CssClass="form-control input-sm totalsDestroyed number" runat="server"></asp:TextBox></div></td>
      <td> <div class="form-group form-inline"> <asp:TextBox ID="sfhCovByInsurance" placeholder="0" CssClass="form-control input-sm" runat="server" onBlur="iaAverage()"></asp:TextBox></div>%</td><!--added % and onBlur iaAverage PO 081916-->
    </tr>
    <tr>
      <td>Mobile Homes <span id="mobileHomesInfo" class="label label-info">i</span></td>
      <td> <div class="form-group form-inline"><asp:TextBox ID="mhAffected" placeholder="0" CssClass="form-control input-sm  totalsAffected number" runat="server"></asp:TextBox></div></td>
      <td> <div class="form-group form-inline"><asp:TextBox ID="mhMinorDamage" placeholder="0" CssClass="form-control input-sm totalsMinorDamage number" runat="server"></asp:TextBox></div></td>
      <td> <div class="form-group form-inline"><asp:TextBox ID="mhMajorDamage" placeholder="0" CssClass="form-control input-sm totalsMajorDamage number" runat="server"></asp:TextBox></div></td>
      <td> <div class="form-group form-inline"><asp:TextBox ID="mhDestroyed" placeholder="0" CssClass="form-control input-sm totalsDestroyed number" runat="server"></asp:TextBox></div></td>
      <td> <div class="form-group form-inline"><asp:TextBox ID="mhCovByInsurance" placeholder="0" CssClass="form-control input-sm" runat="server" onBlur="iaAverage()"></asp:TextBox></div>%</td><!--added % and onBlur iaAverage PO 081916-->
    </tr>
<tr>
      <td>Multi-Family Units <span id="multiFamilyUnitInfo" class="label label-info">i</span></td>
      <td> <div class="form-group form-inline"><asp:TextBox ID="mfuAffected" placeholder="0" CssClass="form-control input-sm  totalsAffected number" runat="server"></asp:TextBox></div></td>
      <td> <div class="form-group form-inline"><asp:TextBox ID="mfuMinorDamage" placeholder="0" CssClass="form-control input-sm totalsMinorDamage number" runat="server"></asp:TextBox></div></td>
      <td><div class="form-group form-inline"> <asp:TextBox ID="mfuMajorDamage" placeholder="0" CssClass="form-control input-sm totalsMajorDamage number" runat="server"></asp:TextBox></div></td>
      <td><div class="form-group form-inline"> <asp:TextBox ID="mfuDestroyed" placeholder="0" CssClass="form-control input-sm totalsDestroyed number" runat="server"></asp:TextBox></div></td>
      <td><div class="form-group form-inline"> <asp:TextBox ID="mfuCovByInsurance" placeholder="0" CssClass="form-control input-sm" runat="server" onBlur="iaAverage()"></asp:TextBox></div>%</td><!--added % and onBlur iaAverage PO 081916-->
    </tr>
<tr>
      <td>Totals</td>
      <td> <div class="form-group form-inline"><asp:TextBox ID="totalsAffected" placeholder="0" CssClass="form-control input-sm number" runat="server"></asp:TextBox></div></td>
      <td> <div class="form-group form-inline"><asp:TextBox ID="totalsMinorDamage" placeholder="0" CssClass="form-control input-sm number" runat="server"></asp:TextBox></div></td>
      <td> <div class="form-group form-inline"><asp:TextBox ID="totalsMajorDamage" placeholder="0" CssClass="form-control input-sm number" runat="server"></asp:TextBox></div></td>
      <td> <div class="form-group form-inline"><asp:TextBox ID="totalsDestroyed" placeholder="0" CssClass="form-control input-sm number" runat="server"></asp:TextBox></div></td>
      <td> <div class="form-group form-inline"><asp:TextBox ID="totalsCovByInsurance" placeholder="0" CssClass="form-control input-sm" runat="server"></asp:TextBox></div>%</td><!--added %  PO 081916-->
    </tr>
</table>
            
<div class="form-group form-inline">
      <label class="control-label" for="homesIsolated">Number of homes isolated due to road closure (high water, etc.):</label>
       <asp:TextBox ID="homesIsolated" CssClass="form-control input-sm" runat="server"></asp:TextBox>
    </div>
    <br/>   
<!--<div class="form-group form-inline">
      <label class="control-label" for="numNotSatisfiedByVolunteers">Estimated number of persons whose situation will not be satisfied by volunteer organizations (Contact local volunteer organizations):</label>
       <asp:TextBox ID="numNotSatisfiedByVolunteers" CssClass="form-control input-sm" runat="server"></asp:TextBox>
    </div>-->
<!--<div class="form-group form-inline">
      <label class="control-label" for="sheltersOpen">Are shelters opened?:</label>
        <asp:RadioButton ID="sheltersOpen1" CssClass="form-control input-sm" GroupName="sheltersOpen" runat="server" Text="Yes" />
        <asp:RadioButton ID="sheltersOpen2" CssClass="form-control input-sm" GroupName="sheltersOpen" runat="server" Text="No" />
    </div>
<div class="form-group form-inline" id="sheltersHowManyDiv">
      <label class="control-label" for="sheltersHowMany">How many shelters are open?:</label>
       <asp:TextBox ID="sheltersHowMany" CssClass="form-control input-sm" runat="server"></asp:TextBox>
    </div>
<div class="form-group form-inline">
      <label class="control-label" for="shelterDetails">Name, location, capacity, and current occupancy of shelters:</label>
       <asp:TextBox ID="shelterDetails" CssClass="form-control" runat="server" TextMode="MultiLine" Rows="5"></asp:TextBox>
    </div>
            -->
<h1><span class="label label-default">Business Losses/Impacts:</span></h1>
<br/>
            <table class="table table-bordered" id="busLosses">
                <tr>
                    <td></td><td>Number</td><td># Covered by Adequate Insurance</td><td>Total estimated repair cost</td>
                </tr>
                <tr>
                    <td>Minor Damage (less than 40%)</td>
                    <td><div class="form-group form-inline"><asp:TextBox ID="numberMinorDamage" placeholder="0" CssClass="form-control input-sm numberTotal number" runat="server"></asp:TextBox></div></td>
                    <td><div class="form-group form-inline"><asp:TextBox ID="coveredMinorDamage" placeholder="0" CssClass="form-control input-sm coveredTotal number" runat="server"></asp:TextBox></div></td>
                    <td><div class="form-group form-inline"><asp:TextBox ID="totalMinorDamage" placeholder="0" CssClass="form-control input-sm totalTotal number" runat="server"></asp:TextBox></div></td>
                </tr>
                <tr>
                    <td>Major Damage (greater than 40%)</td>
                    <td><div class="form-group form-inline"><asp:TextBox ID="numberMajorDamage" placeholder="0" CssClass="form-control input-sm numberTotal number" runat="server"></asp:TextBox></div></td>
                    <td><div class="form-group form-inline"><asp:TextBox ID="coveredMajorDamage" placeholder="0" CssClass="form-control input-sm coveredTotal number" runat="server"></asp:TextBox></div></td>
                    <td><div class="form-group form-inline"><asp:TextBox ID="totalMajorDamage" placeholder="0" CssClass="form-control input-sm totalTotal number" runat="server"></asp:TextBox></div></td>
                </tr>
                 <tr>
                    <td>Total</td>
                    <td><div class="form-group form-inline"><asp:TextBox ID="numberTotal" placeholder="0" CssClass="form-control input-sm number" runat="server"></asp:TextBox></div></td>
                    <td><div class="form-group form-inline"><asp:TextBox ID="coveredTotal" placeholder="0" CssClass="form-control input-sm number" runat="server"></asp:TextBox></div></td>
                    <td><div class="form-group form-inline"><asp:TextBox ID="totalTotal" placeholder="0" CssClass="form-control input-sm number" runat="server"></asp:TextBox></div></td>
                </tr>
            </table>
<div class="form-group form-inline">
      <label class="control-label" for="businessesCeased">How many businesses have ceased operations:</label>
       <asp:TextBox ID="businessesCeased" placeholder="0" CssClass="form-control input-sm" runat="server" ></asp:TextBox>
    </div>
<div class="form-group form-inline">
      <label class="control-label" for="businessesEconomicInjury">How many businesses have experienced economic injury: <span id="businessesEconomicInjuryInfo" class="label label-info">i</span></label>
       <asp:TextBox ID="businessesEconomicInjury" placeholder="0" CssClass="form-control input-sm" runat="server" ></asp:TextBox>
    </div>
<div class="form-group form-inline">
      <label class="control-label" for="numberUnemployed">Estimated number of persons unemployed because of this disaster: </label>
       <asp:TextBox ID="numberUnemployed" placeholder="0" CssClass="form-control input-sm" runat="server" ></asp:TextBox><i> (Contact affected businesses and the local Texas Workforce Commission Office)</i>
    </div>
    <br/>
<h1><span class="label label-default">PUBLIC ASSISTANCE</span></h1>
<br/>
<table class="table table-bordered">
    <tr>
        <td>Category</td>
        <td>No of Sites</td>
        <td>Estimated Repair Costs</td>
        <td>Anticipated Insurance*</td>
    </tr>
    <tr>
        <td><span class="label label-default" id="catAInfo">A</span> Debris Clearance</td>
        <td><asp:TextBox ID="sitesDebrisClearance" placeholder="0" CssClass="form-control input-sm sitesTotals number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="repairCostDebrisClearance" placeholder="0" CssClass="form-control input-sm repairCostTotals number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="insuranceDebrisClearance" placeholder="0" CssClass="form-control input-sm insuranceTotals number" runat="server" ></asp:TextBox></td>
    </tr>
     <tr>
        <td><span class="label label-default" id="catBInfo">B</span> Emergency Protective Measures <span id="emergencyProtectiveMeasuresInfo" class="label label-info">i</span></td>
        <td><asp:TextBox ID="sitesEmergency" placeholder="0" CssClass="form-control input-sm sitesTotals number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="repairCostEmergency" placeholder="0" CssClass="form-control input-sm repairCostTotals number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="insuranceEmergency" placeholder="0" CssClass="form-control input-sm insuranceTotals number" runat="server" ></asp:TextBox></td>
    </tr>
     <tr>
        <td><span class="label label-default" id="catCInfo">C</span> Roads & Bridges</td>
        <td><asp:TextBox ID="sitesRoadPaved" placeholder="0" CssClass="form-control input-sm sitesTotals number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="repairCostRoadPaved" placeholder="0" CssClass="form-control input-sm repairCostTotals number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="insuranceRoadPaved" placeholder="0" CssClass="form-control input-sm insuranceTotals number" runat="server" ></asp:TextBox></td>
    </tr>
    
    <tr>
        <td><span class="label label-default" id="catDInfo">D</span> Water Control Facilities <br />(Dams, levees, dikes)
</td>
        <td><asp:TextBox ID="sitesWaterControlFacilities" placeholder="0" CssClass="form-control input-sm sitesTotals number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="repairCostWaterControlFacilities" placeholder="0" CssClass="form-control input-sm repairCostTotals number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="insuranceWaterControlFacilities" placeholder="0" CssClass="form-control input-sm insuranceTotals number" runat="server" ></asp:TextBox></td>
    </tr>
<tr>
        <td><span class="label label-default" id="catEInfo">E</span> Buildings & Equipment <span id="buildingEquipmentInfo" class="label label-info">i</span>
</td>
        <td><asp:TextBox ID="sitesBuildingsEquipment" placeholder="0" CssClass="form-control input-sm sitesTotals number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="repairCostBuildingsEquipment" placeholder="0" CssClass="form-control input-sm repairCostTotals number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="insuranceBuildingsEquipment" placeholder="0" CssClass="form-control input-sm insuranceTotals number" runat="server" ></asp:TextBox></td>
    </tr>
    <tr>
        <td><span class="label label-default" id="catFInfo">F</span> Public Utility Systems<br />
(Gas, Electric, Sewer, Water)
</td>
        <td><asp:TextBox ID="sitesUtilitySystems" placeholder="0" CssClass="form-control input-sm sitesTotals number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="repairCostUtilitySystems" placeholder="0" CssClass="form-control input-sm repairCostTotals number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="insuranceUtilitySystems" placeholder="0" CssClass="form-control input-sm insuranceTotals number" runat="server" ></asp:TextBox></td>
    </tr>
<tr>
        <td><span class="label label-default" id="catGInfo">G</span>
            Other Types of Facilities<br />
(Recreational Facilities, Airports, etc.)
</td>
        <td><asp:TextBox ID="sitesOther" placeholder="0" CssClass="form-control input-sm sitesTotals number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="repairCostOther" placeholder="0" CssClass="form-control input-sm repairCostTotals number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="insuranceOther" placeholder="0" CssClass="form-control input-sm insuranceTotals number" runat="server" ></asp:TextBox></td>
    </tr>
    <tr>
        <td>Totals
</td>
        <td><asp:TextBox ID="sitesTotals" placeholder="0" CssClass="form-control input-sm number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="repairCostTotals" placeholder="0" CssClass="form-control input-sm number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="insuranceTotals" placeholder="0" CssClass="form-control input-sm number" runat="server" ></asp:TextBox></td>
    </tr>
</table>
            <i>* Anticipated insurance is normally calculated by subtracting any deductible, depreciation or 
     uncoverable loss from the estimated repair cost.
</i>
<br/>
<div class="form-group form-inline">
      <label class="control-label" for="annualMaintenanceBudget">Total annual maintenance budget (i.e. Public Works, Road & Bridge):</label>
       <asp:TextBox ID="annualMaintenanceBudget"  placeholder="0" CssClass="form-control input-sm" runat="server" ></asp:TextBox>
    </div>
<div class="form-group form-inline">
      <label class="control-label" for="startOfFiscalYear">Start of Fiscal Year(Month):</label>
       <asp:TextBox ID="startOfFiscalYear" CssClass="form-control input-sm" runat="server" ></asp:TextBox>
    </div>
    <br/>
<h1><span class="label label-default">Other Eligible Entities</span></h1>
<br/>
            <i>(Contact non-profit or governmental, medical, emergency, utility, educational, custodial care facilities, etc.)</i>
            <br/>
<table class="table table-bordered">
    <tr>
        <td>Organization/ Facility</td>
        <td>Cat A-G</td>
        <td>No. of Sites</td>
        <td>Estimated Repair Cost</td>
        <td>Anticipated Insurance *</td>
    </tr>
    <tr>
        <td><asp:TextBox ID="orgFacility01" CssClass="form-control input-sm" runat="server" ></asp:TextBox></td>
        <td>
            <asp:DropDownList ID="cat01" CssClass="form-control input-sm" runat="server">
               <asp:ListItem></asp:ListItem>
                 <asp:ListItem>A</asp:ListItem>
                <asp:ListItem>B</asp:ListItem>
                <asp:ListItem>C</asp:ListItem>
                <asp:ListItem>D</asp:ListItem>
                <asp:ListItem>E</asp:ListItem>
                <asp:ListItem>F</asp:ListItem>
                <asp:ListItem>G</asp:ListItem>
            </asp:DropDownList></td>
        <td><asp:TextBox ID="sites01"  placeholder="0" CssClass="form-control input-sm sitesOtherTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="repairCost01" placeholder="0" CssClass="form-control input-sm repairCostTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="insurance01" placeholder="0" CssClass="form-control input-sm insuranceCostTotal number" runat="server" ></asp:TextBox></td>
    </tr>
<tr>
        <td><asp:TextBox ID="orgFacility02" CssClass="form-control input-sm" runat="server" ></asp:TextBox></td>
     <td>
            <asp:DropDownList ID="cat02" CssClass="form-control input-sm" runat="server">
               <asp:ListItem></asp:ListItem>
                 <asp:ListItem>A</asp:ListItem>
                <asp:ListItem>B</asp:ListItem>
                <asp:ListItem>C</asp:ListItem>
                <asp:ListItem>D</asp:ListItem>
                <asp:ListItem>E</asp:ListItem>
                <asp:ListItem>F</asp:ListItem>
                <asp:ListItem>G</asp:ListItem>
            </asp:DropDownList></td>    
    <td><asp:TextBox ID="sites02" placeholder="0" CssClass="form-control input-sm sitesOtherTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="repairCost02" placeholder="0" CssClass="form-control input-sm repairCostTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="insurance02" placeholder="0" CssClass="form-control input-sm insuranceCostTotal number" runat="server" ></asp:TextBox></td>
    </tr>
    <tr>
        <td><asp:TextBox ID="orgFacility03" CssClass="form-control input-sm" runat="server" ></asp:TextBox></td>
         <td>
            <asp:DropDownList ID="cat03" CssClass="form-control input-sm" runat="server">
               <asp:ListItem></asp:ListItem>
                 <asp:ListItem>A</asp:ListItem>
                <asp:ListItem>B</asp:ListItem>
                <asp:ListItem>C</asp:ListItem>
                <asp:ListItem>D</asp:ListItem>
                <asp:ListItem>E</asp:ListItem>
                <asp:ListItem>F</asp:ListItem>
                <asp:ListItem>G</asp:ListItem>
            </asp:DropDownList></td>
        <td><asp:TextBox ID="sites03" placeholder="0" CssClass="form-control input-sm sitesOtherTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="repairCost03" placeholder="0" CssClass="form-control input-sm repairCostTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="insurance03" placeholder="0" CssClass="form-control input-sm insuranceCostTotal number" runat="server" ></asp:TextBox></td>
    </tr>
    <tr>
        <td><asp:TextBox ID="orgFacility04" CssClass="form-control input-sm" runat="server" ></asp:TextBox></td>
        <td>
            <asp:DropDownList ID="cat04" CssClass="form-control input-sm" runat="server">
               <asp:ListItem></asp:ListItem>
                 <asp:ListItem>A</asp:ListItem>
                <asp:ListItem>B</asp:ListItem>
                <asp:ListItem>C</asp:ListItem>
                <asp:ListItem>D</asp:ListItem>
                <asp:ListItem>E</asp:ListItem>
                <asp:ListItem>F</asp:ListItem>
                <asp:ListItem>G</asp:ListItem>
            </asp:DropDownList></td>
         <td><asp:TextBox ID="sites04" placeholder="0" CssClass="form-control input-sm sitesOtherTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="repairCost04" placeholder="0" CssClass="form-control input-sm repairCostTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="insurance04" placeholder="0" CssClass="form-control input-sm insuranceCostTotal number" runat="server" ></asp:TextBox></td>
    </tr>
    <tr>
        <td><asp:TextBox ID="orgFacility05" CssClass="form-control input-sm" runat="server" ></asp:TextBox></td>
         <td>
            <asp:DropDownList ID="cat05" CssClass="form-control input-sm" runat="server">
               <asp:ListItem></asp:ListItem>
                 <asp:ListItem>A</asp:ListItem>
                <asp:ListItem>B</asp:ListItem>
                <asp:ListItem>C</asp:ListItem>
                <asp:ListItem>D</asp:ListItem>
                <asp:ListItem>E</asp:ListItem>
                <asp:ListItem>F</asp:ListItem>
                <asp:ListItem>G</asp:ListItem>
            </asp:DropDownList></td>
        <td><asp:TextBox ID="sites05" placeholder="0" CssClass="form-control input-sm sitesOtherTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="repairCost05" placeholder="0" CssClass="form-control input-sm repairCostTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="insurance05" placeholder="0" CssClass="form-control input-sm insuranceCostTotal number" runat="server" ></asp:TextBox></td>
    </tr>
    <tr>
        <td><asp:TextBox ID="orgFacility06" CssClass="form-control input-sm" runat="server" ></asp:TextBox></td>
         <td>
            <asp:DropDownList ID="cat06" CssClass="form-control input-sm" runat="server">
               <asp:ListItem></asp:ListItem>
                 <asp:ListItem>A</asp:ListItem>
                <asp:ListItem>B</asp:ListItem>
                <asp:ListItem>C</asp:ListItem>
                <asp:ListItem>D</asp:ListItem>
                <asp:ListItem>E</asp:ListItem>
                <asp:ListItem>F</asp:ListItem>
                <asp:ListItem>G</asp:ListItem>
            </asp:DropDownList></td>
        <td><asp:TextBox ID="sites06" placeholder="0" CssClass="form-control input-sm sitesOtherTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="repairCost06" placeholder="0" CssClass="form-control input-sm repairCostTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="insurance06" placeholder="0" CssClass="form-control input-sm insuranceCostTotal number" runat="server" ></asp:TextBox></td>
    </tr>
    <tr>
        <td><asp:TextBox ID="orgFacility07" CssClass="form-control input-sm" runat="server" ></asp:TextBox></td>
        <td>
            <asp:DropDownList ID="cat07" CssClass="form-control input-sm" runat="server">
               <asp:ListItem></asp:ListItem>
                 <asp:ListItem>A</asp:ListItem>
                <asp:ListItem>B</asp:ListItem>
                <asp:ListItem>C</asp:ListItem>
                <asp:ListItem>D</asp:ListItem>
                <asp:ListItem>E</asp:ListItem>
                <asp:ListItem>F</asp:ListItem>
                <asp:ListItem>G</asp:ListItem>
            </asp:DropDownList></td>
         <td><asp:TextBox ID="sites07" placeholder="0" CssClass="form-control input-sm sitesOtherTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="repairCost07" placeholder="0" CssClass="form-control input-sm repairCostTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="insurance07" placeholder="0" CssClass="form-control input-sm insuranceCostTotal number" runat="server" ></asp:TextBox></td>
    </tr>
    <tr>
        <td><asp:TextBox ID="orgFacility08" CssClass="form-control input-sm" runat="server" ></asp:TextBox></td>
         <td>
            <asp:DropDownList ID="cat08" CssClass="form-control input-sm" runat="server">
               <asp:ListItem></asp:ListItem>
                 <asp:ListItem>A</asp:ListItem>
                <asp:ListItem>B</asp:ListItem>
                <asp:ListItem>C</asp:ListItem>
                <asp:ListItem>D</asp:ListItem>
                <asp:ListItem>E</asp:ListItem>
                <asp:ListItem>F</asp:ListItem>
                <asp:ListItem>G</asp:ListItem>
            </asp:DropDownList></td>
        <td><asp:TextBox ID="sites08" placeholder="0" CssClass="form-control input-sm sitesOtherTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="repairCost08" placeholder="0" CssClass="form-control input-sm repairCostTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="insurance08" placeholder="0" CssClass="form-control input-sm insuranceCostTotal number" runat="server" ></asp:TextBox></td>
    </tr>
    <tr>
        <td><asp:TextBox ID="orgFacility09" CssClass="form-control input-sm" runat="server" ></asp:TextBox></td>
         <td>
            <asp:DropDownList ID="cat09" CssClass="form-control input-sm" runat="server">
               <asp:ListItem></asp:ListItem>
                 <asp:ListItem>A</asp:ListItem>
                <asp:ListItem>B</asp:ListItem>
                <asp:ListItem>C</asp:ListItem>
                <asp:ListItem>D</asp:ListItem>
                <asp:ListItem>E</asp:ListItem>
                <asp:ListItem>F</asp:ListItem>
                <asp:ListItem>G</asp:ListItem>
            </asp:DropDownList></td>
        <td><asp:TextBox ID="sites09" placeholder="0" CssClass="form-control input-sm sitesOtherTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="repairCost09" placeholder="0" CssClass="form-control input-sm repairCostTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="insurance09" placeholder="0" CssClass="form-control input-sm insuranceCostTotal number" runat="server" ></asp:TextBox></td>
    </tr>
    <tr>
        <td><asp:TextBox ID="orgFacility10" CssClass="form-control input-sm" runat="server" ></asp:TextBox></td>
         <td>
            <asp:DropDownList ID="cat10" CssClass="form-control input-sm" runat="server">
               <asp:ListItem></asp:ListItem>
                 <asp:ListItem>A</asp:ListItem>
                <asp:ListItem>B</asp:ListItem>
                <asp:ListItem>C</asp:ListItem>
                <asp:ListItem>D</asp:ListItem>
                <asp:ListItem>E</asp:ListItem>
                <asp:ListItem>F</asp:ListItem>
                <asp:ListItem>G</asp:ListItem>
            </asp:DropDownList></td>
        <td><asp:TextBox ID="sites10" placeholder="0" CssClass="form-control input-sm sitesOtherTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="repairCost10" placeholder="0" CssClass="form-control input-sm repairCostTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="insurance10" placeholder="0" CssClass="form-control input-sm insuranceCostTotal number" runat="server" ></asp:TextBox></td>
    </tr>
    <tr>
        <td><asp:TextBox ID="orgFacility11" CssClass="form-control input-sm" runat="server" ></asp:TextBox></td>
         <td>
            <asp:DropDownList ID="cat11" CssClass="form-control input-sm" runat="server">
               <asp:ListItem></asp:ListItem>
                 <asp:ListItem>A</asp:ListItem>
                <asp:ListItem>B</asp:ListItem>
                <asp:ListItem>C</asp:ListItem>
                <asp:ListItem>D</asp:ListItem>
                <asp:ListItem>E</asp:ListItem>
                <asp:ListItem>F</asp:ListItem>
                <asp:ListItem>G</asp:ListItem>
            </asp:DropDownList></td>
        <td><asp:TextBox ID="sites11" placeholder="0" CssClass="form-control input-sm sitesOtherTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="repairCost11" placeholder="0" CssClass="form-control input-sm repairCostTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="insurance11" placeholder="0" CssClass="form-control input-sm insuranceCostTotal number" runat="server" ></asp:TextBox></td>
    </tr>
    <tr>
        <td><asp:TextBox ID="orgFacility12" CssClass="form-control input-sm" runat="server" ></asp:TextBox></td>
        <td>
            <asp:DropDownList ID="cat12" CssClass="form-control input-sm" runat="server">
               <asp:ListItem></asp:ListItem>
                 <asp:ListItem>A</asp:ListItem>
                <asp:ListItem>B</asp:ListItem>
                <asp:ListItem>C</asp:ListItem>
                <asp:ListItem>D</asp:ListItem>
                <asp:ListItem>E</asp:ListItem>
                <asp:ListItem>F</asp:ListItem>
                <asp:ListItem>G</asp:ListItem>
            </asp:DropDownList></td>
         <td><asp:TextBox ID="sites12" placeholder="0" CssClass="form-control input-sm sitesOtherTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="repairCost12" placeholder="0" CssClass="form-control input-sm repairCostTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="insurance12" placeholder="0" CssClass="form-control input-sm insuranceCostTotal number" runat="server" ></asp:TextBox></td>
    </tr>
    <tr>
        <td><asp:TextBox ID="orgFacility13" CssClass="form-control input-sm" runat="server" ></asp:TextBox></td>
        <td>
            <asp:DropDownList ID="cat13" CssClass="form-control input-sm" runat="server">
               <asp:ListItem></asp:ListItem>
                 <asp:ListItem>A</asp:ListItem>
                <asp:ListItem>B</asp:ListItem>
                <asp:ListItem>C</asp:ListItem>
                <asp:ListItem>D</asp:ListItem>
                <asp:ListItem>E</asp:ListItem>
                <asp:ListItem>F</asp:ListItem>
                <asp:ListItem>G</asp:ListItem>
            </asp:DropDownList></td>
         <td><asp:TextBox ID="sites13" placeholder="0" CssClass="form-control input-sm sitesOtherTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="repairCost13" placeholder="0" CssClass="form-control input-sm repairCostTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="insurance13" placeholder="0" CssClass="form-control input-sm insuranceCostTotal number" runat="server" ></asp:TextBox></td>
    </tr>
    <tr>
        <td><asp:TextBox ID="orgFacility14" CssClass="form-control input-sm" runat="server" ></asp:TextBox></td>
        <td>
            <asp:DropDownList ID="cat14" CssClass="form-control input-sm" runat="server">
               <asp:ListItem></asp:ListItem>
                 <asp:ListItem>A</asp:ListItem>
                <asp:ListItem>B</asp:ListItem>
                <asp:ListItem>C</asp:ListItem>
                <asp:ListItem>D</asp:ListItem>
                <asp:ListItem>E</asp:ListItem>
                <asp:ListItem>F</asp:ListItem>
                <asp:ListItem>G</asp:ListItem>
            </asp:DropDownList></td>
         <td><asp:TextBox ID="sites14" placeholder="0" CssClass="form-control input-sm sitesOtherTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="repairCost14" placeholder="0" CssClass="form-control input-sm repairCostTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="insurance14" placeholder="0" CssClass="form-control input-sm insuranceCostTotal number" runat="server" ></asp:TextBox></td>
    </tr>
    <tr>
        <td><asp:TextBox ID="orgFacility15" CssClass="form-control input-sm" runat="server" ></asp:TextBox></td>
         <td>
            <asp:DropDownList ID="cat15" CssClass="form-control input-sm" runat="server">
               <asp:ListItem></asp:ListItem>
                 <asp:ListItem>A</asp:ListItem>
                <asp:ListItem>B</asp:ListItem>
                <asp:ListItem>C</asp:ListItem>
                <asp:ListItem>D</asp:ListItem>
                <asp:ListItem>E</asp:ListItem>
                <asp:ListItem>F</asp:ListItem>
                <asp:ListItem>G</asp:ListItem>
            </asp:DropDownList></td>
        <td><asp:TextBox ID="sites15" placeholder="0" CssClass="form-control input-sm sitesOtherTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="repairCost15" placeholder="0" CssClass="form-control input-sm repairCostTotal number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="insurance15" placeholder="0" CssClass="form-control input-sm insuranceCostTotal number" runat="server" ></asp:TextBox></td>
    </tr>
    <tr>
        <td>Totals</td>
        <td></td>
        <td><asp:TextBox ID="sitesOtherTotal" placeholder="0" CssClass="form-control input-sm number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="repairCostTotal" placeholder="0" CssClass="form-control input-sm number" runat="server" ></asp:TextBox></td>
        <td><asp:TextBox ID="insuranceCostTotal" placeholder="0" CssClass="form-control input-sm number" runat="server" ></asp:TextBox></td>
    </tr>
</table>
            <br/>
<div>
This form is for damage assessment reporting purposes only.  In accordance with the State Emergency Management Plan, if a Mayor/County Judge determines that a situation is of such severity and magnitude that an effective response is beyond the affected jurisdiction’s capability to recover, a letter outlining the disaster impact and the need for supplemental State and/or Federal assistance must accompany this DSO.
</div>

           
                 <h1> <span class="label label-default">General Notes</span></h1>
                 <br/>
            <div class="form-group form-inline">
      <label class="control-label" for="notes">Notes:</label>
                <asp:TextBox ID="notes" runat="server" CssClass="form-control" Rows="5" Columns="70" TextMode="MultiLine"></asp:TextBox>
                </div>
 <h1> <span class="label label-default">Submitter Information</span></h1>
<br/>
<div class="form-group form-inline required">
      <label class="control-label" for="submitterName">Name:</label>
       <asp:TextBox ID="submitterName" CssClass="form-control input-sm" runat="server" ></asp:TextBox>
    </div>
    <i> If you include your email, a confirmation email will be sent to you.</i>
    <br/>
    <div class="form-group form-inline required">
      <label class="control-label" for="submitterEmail">Email:</label>
       <asp:TextBox ID="submitterEmail" CssClass="form-control input-sm" runat="server" ></asp:TextBox>
    </div>
              

             <div id="countyEmailSection" class="form-group form-inline hidden">
      <label class="control-label" for="countyEmail">County Emails<span id="Span1" class="label label-info">i</span>:</label>
       <asp:TextBox ID="countyEmail" CssClass="form-control input-lg" runat="server" ></asp:TextBox>
    </div>
            <div class="form-group form-inline hidden">
      <label class="control-label" for="ddcEmail">DDC Emails<span id="Span2" class="label label-info">i</span>:</label>
       <asp:TextBox ID="ddcEmail" CssClass="form-control input-lg" runat="server" ></asp:TextBox>
    </div>
            
               
 <div class="form-group form-inline">
      <label class="control-label" for="submitterEmail">Additional Emails: <span id="additionalEmailsInfo" class="label label-info">i</span></label>
       <asp:TextBox ID="additionalEmails" CssClass="form-control input-lg" runat="server" ></asp:TextBox>
    </div>
            </div>

        </div>

        <div style="display:none">
      <label class="control-label" for="notes">Audit:</label>
                <asp:TextBox ID="audit" runat="server" CssClass="form-control" Rows="5" Columns="70" TextMode="MultiLine"></asp:TextBox>
                </div>
        <asp:Button ID="saveCmd" runat="server" Text="Submit" OnClick="saveCmd_Click" CssClass="btn btn-primary" />
        <asp:Button ID="cancelBttn" runat="server" Text="Cancel" OnClick="cancelBttn_Click" CssClass="btn btn-default" />
    </form>
</body>
</html>
