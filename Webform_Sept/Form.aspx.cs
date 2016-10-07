using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Net.Mail;
using System.Xml;
using System.IO;

namespace DSO
{
    public partial class Form : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {


                if (Session["State"] != "Valid")
                {
                    Response.Redirect("Default.aspx");
                }
                else
                {
                    if (Session["entryType"] == "Live")
                {
                    entryType.InnerHtml = "Live";
                    }
                        if (Session["entryType"] == "Training")
                        {
                            entryType.InnerHtml = "Training - No Emails will be sent";
                    }

                    //Add county options
                    string[] colist = new[] { "Select One", "Anderson", "Andrews", "Angelina", "Aransas", "Archer", "Armstrong", "Atascosa", "Austin", "Bailey", "Bandera", "Bastrop", "Baylor", "Bee", "Bell", "Bexar", "Blanco", "Borden", "Bosque", "Bowie", "Brazoria", "Brazos", "Brewster", "Briscoe", "Brooks", "Brown", "Burleson", "Burnet", "Caldwell", "Calhoun", "Callahan", "Cameron", "Camp", "Carson", "Cass", "Castro", "Chambers", "Cherokee", "Childress", "Clay", "Cochran", "Coke", "Coleman", "Collin", "Collingsworth", "Colorado", "Comal", "Comanche", "Concho", "Cooke", "Coryell", "Cottle", "Crane", "Crockett", "Crosby", "Culberson", "Dallam", "Dallas", "Dawson", "Deaf Smith", "Delta", "Denton", "DeWitt", "Dickens", "Dimmit", "Donley", "Duval", "Eastland", "Ector", "Edwards", "El Paso", "Ellis", "Erath", "Falls", "Fannin", "Fayette", "Fisher", "Floyd", "Foard", "Fort Bend", "Franklin", "Freestone", "Frio", "Gaines", "Galveston", "Garza", "Gillespie", "Glasscock", "Goliad", "Gonzales", "Gray", "Grayson", "Gregg", "Grimes", "Guadalupe", "Hale", "Hall", "Hamilton", "Hansford", "Hardeman", "Hardin", "Harris", "Harrison", "Hartley", "Haskell", "Hays", "Hemphill", "Henderson", "Hidalgo", "Hill", "Hockley", "Hood", "Hopkins", "Houston", "Howard", "Hudspeth", "Hunt", "Hutchinson", "Irion", "Jack", "Jackson", "Jasper", "Jeff Davis", "Jefferson", "Jim Hogg", "Jim Wells", "Johnson", "Jones", "Karnes", "Kaufman", "Kendall", "Kenedy", "Kent", "Kerr", "Kimble", "King", "Kinney", "Kleberg", "Knox", "La Salle", "Lamar", "Lamb", "Lampasas", "Lavaca", "Lee", "Leon", "Liberty", "Limestone", "Lipscomb", "Live Oak", "Llano", "Loving", "Lubbock", "Lynn", "Madison", "Marion", "Martin", "Mason", "Matagorda", "Maverick", "McCulloch", "McLennan", "McMullen", "Medina", "Menard", "Midland", "Milam", "Mills", "Mitchell", "Montague", "Montgomery", "Moore", "Morris", "Motley", "Nacogdoches", "Navarro", "Newton", "Nolan", "Nueces", "Ochiltree", "Oldham", "Orange", "Palo Pinto", "Panola", "Parker", "Parmer", "Pecos", "Polk", "Potter", "Presidio", "Rains", "Randall", "Reagan", "Real", "Red River", "Reeves", "Refugio", "Roberts", "Robertson", "Rockwall", "Runnels", "Rusk", "Sabine", "San Augustine", "San Jacinto", "San Patricio", "San Saba", "Schleicher", "Scurry", "Shackelford", "Shelby", "Sherman", "Smith", "Somervell", "Starr", "Stephens", "Sterling", "Stonewall", "Sutton", "Swisher", "Tarrant", "Taylor", "Terrell", "Terry", "Throckmorton", "Titus", "Tom Green", "Travis", "Trinity", "Tyler", "Upshur", "Upton", "Uvalde", "Val Verde", "Van Zandt", "Victoria", "Walker", "Waller", "Ward", "Washington", "Webb", "Wharton", "Wheeler", "Wichita", "Wilbarger", "Willacy", "Williamson", "Wilson", "Winkler", "Wise", "Wood", "Yoakum", "Young", "Zapata", "Zavala" };
                    foreach (string co in colist)
                    {
                        county.Items.Add(co);
                    }
                    //Add City Options
                    string[] city1 = new[] { "Select One", "Unincorporated Areas", "Abbott", "Abernathy", "Abilene", "Ackerly", "Addison", "Adrian", "Agua Dulce", "Alamo", "Alamo Heights", "Alba", "Albany", "Aledo", "Alice", "Allen", "Alma", "Alpine", "Alto", "Alton", "Alvarado", "Alvin", "Alvord", "Amarillo", "Ames", "Amherst", "Anahuac", "Anderson", "Andrews", "Angleton", "Angus", "Anna", "Annetta", "Annetta North", "Annetta South", "Annona", "Anson", "Anthony", "Anton", "Appleby", "Aquilla", "Aransas Pass", "Archer City", "Arcola", "Argyle", "Arlington", "Arp", "Asherton", "Aspermont", "Athens", "Atlanta", "Aubrey", "Aurora", "Austin", "Austwell", "Avery", "Avinger", "Azle", "Bailey", "Bailey's Prairie", "Baird", "Balch Springs", "Balcones Heights", "Ballinger", "Balmorhea", "Bandera", "Bangs", "Bardwell", "Barry", "Barstow", "Bartlett", "Bartonville", "Bastrop", "Bay City", "Bayou Vista", "Bayside", "Baytown", "Bayview", "Beach City", "Bear Creek", "Beasley", "Beaumont", "Beckville", "Bedford", "Bedias", "Bee Cave", "Beeville", "Bellaire", "Bellevue", "Bellmead", "Bells", "Bellville", "Belton", "Benavides", "Benbrook", "Benjamin", "Berryville", "Bertram", "Beverly Hills", "Bevil Oaks", "Big Lake", "Big Sandy", "Big Spring", "Big Wells", "Bishop", "Bishop Hills", "Blackwell", "Blanco", "Blanket", "Bloomburg", "Blooming Grove", "Blossom", "Blue Mound", "Blue Ridge", "Blum", "Boerne", "Bogata", "Bonham", "Bonney", "Booker", "Borger", "Bovina", "Bowie", "Boyd", "Brackettville", "Brady", "Brazoria", "Brazos Bend", "Brazos Country", "Breckenridge", "Bremond", "Brenham", "Briarcliff", "Briaroaks", "Bridge City", "Bridgeport", "Broaddus", "Bronte", "Brookshire", "Brookside Village", "Browndell", "Brownfield", "Brownsboro", "Brownsville", "Brownwood", "Bruceville-Eddy", "Bryan", "Bryson", "Buckholts", "Buda", "Buffalo", "Buffalo Gap", "Buffalo Springs", "Bullard", "Bulverde", "Bunker Hill Village", "Burkburnett", "Burke", "Burleson", "Burnet", "Burton", "Byers", "Bynum", "Cactus", "Caddo Mills", "Caldwell", "Callisburg", "Calvert", "Cameron", "Camp Wood", "Campbell", "Canadian", "Caney City", "Canton", "Canyon", "Carbon", "Carl's Corner", "Carmine", "Carrizo Springs", "Carrollton", "Carthage", "Cashion", "Castle Hills", "Castroville", "Cedar Hill", "Cedar Park", "Celeste", "Celina", "Center", "Centerville", "Chandler", "Channing", "Charlotte", "Chester", "Chico", "Childress", "Chillicothe", "China", "China Grove", "Chireno", "Christine", "Cibolo", "Cisco", "Clarendon", "Clarksville", "Clarksville City", "Claude", "Clear Lake Shores", "Cleburne", "Cleveland", "Clifton", "Clint", "Clute", "Clyde", "Coahoma", "Cockrell Hill", "Coffee City", "Coldspring", "Coleman", "College Station", "Colleyville", "Collinsville", "Colmesneil", "Colorado City", "Columbus", "Comanche", "Combes", "Combine", "Commerce", "Como", "Conroe", "Converse", "Cool", "Coolidge", "Cooper", "Coppell", "Copper Canyon", "Copperas Cove", "Corinth", "Corpus Christi", "Corral City", "Corrigan", "Corsicana", "Cottonwood", "Cottonwood Shores", "Cotulla", "Cove", "Covington", "Crandall", "Crane", "Cranfills Gap", "Crawford", "Creedmoor", "Cresson", "Crockett", "Crosbyton", "Cross Plains", "Cross Roads", "Cross Timber", "Crowell", "Crowley", "Crystal City", "Cuero", "Cumby", "Cuney", "Cushing", "Cut and Shoot", "Daingerfield", "Daisetta", "Dalhart", "Dallas", "Dalworthington Gardens", "Danbury", "Darrouzett", "Dawson", "Dayton", "Dayton Lakes", "De Leon", "Dean", "Decatur", "DeCordova", "Deer Park", "DeKalb", "Del Rio", "Dell City", "Denison", "Denton", "Denver City", "Deport", "DeSoto", "Detroit", "Devers", "Devine", "Diboll", "Dickens", "Dickinson", "Dilley", "Dimmitt", "Dish", "Dodd City", "Dodson", "Domino", "Donna", "Dorchester", "Double Oak", "Douglassville", "Dripping Springs", "Driscoll", "Dublin", "Dumas", "Duncanville", "Eagle Lake", "Eagle Pass", "Early", "Earth", "East Bernard", "East Mountain", "East Tawakoni", "Eastland", "Easton", "Ector", "Edcouch", "Eden", "Edgecliff", "Edgewood", "Edinburg", "Edmonson", "Edna", "Edom", "El Campo", "El Cenizo", "El Lago", "El Paso", "Eldorado", "Electra", "Elgin", "Elkhart", "Elmendorf", "Elsa", "Emhouse", "Emory", "Enchanted Oaks", "Encinal", "Ennis", "Escobares", "Estelline", "Euless", "Eureka", "Eustace", "Evant", "Everman", "Fair Oaks Ranch", "Fairchilds", "Fairfield", "Fairview", "Falfurrias", "Falls City", "Farmers Branch", "Farmersville", "Farwell", "Fate", "Fayetteville", "Ferris", "Flatonia", "Florence", "Floresville", "Flower Mound", "Floydada", "Follett", "Forest Hill", "Forney", "Forsan", "Fort Stockton", "Fort Worth", "Franklin", "Frankston", "Fredericksburg", "Freeport", "Freer", "Friendswood", "Friona", "Frisco", "Fritch", "Frost", "Fruitvale", "Fulshear", "Fulton", "Gainesville", "Galena Park", "Gallatin", "Galveston", "Ganado", "Garden Ridge", "Garland", "Garrett", "Garrison", "Gary", "Gatesville", "George West", "Georgetown", "Gholson", "Giddings", "Gilmer", "Gladewater", "Glen Rose", "Glenn Heights", "Godley", "Goldsmith", "Goldthwaite", "Goliad", "Golinda", "Gonzales", "Goodlow", "Goodrich", "Gordon", "Goree", "Gorman", "Graford", "Graham", "Granbury", "Grand Prairie", "Grand Saline", "Grandfalls", "Grandview", "Granger", "Granite Shoals", "Granjeno", "Grapeland", "Grapevine", "Grays Prairie", "Greenville", "Gregory", "Grey Forest", "Groesbeck", "Groom", "Groves", "Groveton", "Gruver", "Gun Barrel City", "Gunter", "Gustine", "Hackberry", "Hale Center", "Hallettsville", "Hallsburg", "Hallsville", "Haltom City", "Hamilton", "Hamlin", "Happy", "Hardin", "Harker Heights", "Harlingen", "Hart", "Haskell", "Haslet", "Hawk Cove", "Hawkins", "Hawley", "Hays", "Hearne", "Heath", "Hebron", "Hedley", "Hedwig Village", "Helotes", "Hemphill", "Hempstead", "Henderson", "Henrietta", "Hereford", "Hewitt", "Hickory Creek", "Hico", "Hidalgo", "Hideaway", "Higgins", "Highland Haven", "Highland Park", "Highland Village", "Hill Country Village", "Hillcrest Village", "Hillsboro", "Hilshire Village", "Hitchcock", "Holiday Lakes", "Holland", "Holliday", "Hollywood Park", "Hondo", "Honey Grove", "Hooks", "Horizon City", "Horseshoe Bay", "Houston", "Howardwick", "Howe", "Hubbard", "Hudson", "Hudson Oaks", "Hughes Springs", "Humble", "Hunters Creek Village", "Huntington", "Huntsville", "Hurst", "Hutchins", "Hutto", "Huxley", "Idalou", "Impact", "Indian Lake", "Industry", "Ingleside", "Ingleside On The Bay", "Ingram", "Iola", "Iowa Colony", "Iowa Park", "Iraan", "Iredell", "Irving", "Italy", "Itasca", "Ivanhoe", "Jacinto City", "Jacksboro", "Jacksonville", "Jamaica Beach", "Jarrell", "Jasper", "Jayton", "Jefferson", "Jersey Village", "Jewett", "Joaquin", "Johnson City", "Jolly", "Jones Creek", "Jonestown", "Josephine", "Joshua", "Jourdanton", "Junction", "Justin", "Karnes City", "Katy", "Kaufman", "Keene", "Keller", "Kemah", "Kemp", "Kempner", "Kendleton", "Kenedy", "Kenefick", "Kennard", "Kennedale", "Kerens", "Kermit", "Kerrville", "Kilgore", "Killeen", "Kingsville", "Kirby", "Kirbyville", "Kirvin", "Knollwood", "Knox City", "Kosse", "Kountze", "Kress", "Krugerville", "Krum", "Kurten", "Kyle", "La Feria", "La Grange", "La Grulla", "La Joya", "La Marque", "La Porte", "La Vernia", "La Villa", "La Ward", "LaCoste", "Lacy-Lakeview", "Ladonia", "Lago Vista", "Laguna Vista", "Lake Bridgeport", "Lake City", "Lake Dallas", "Lake Jackson", "Lake Tanglewood", "Lake Worth", "Lakeport", "Lakeside (San Patricio)", "Lakeside (Tarrant)", "Lakeside City", "Lakeview", "Lakeway", "Lakewood Village", "Lamesa", "Lampasas", "Lancaster", "Laredo", "Latexo", "Lavon", "Lawn", "League City", "Leakey", "Leander", "Leary", "Lefors", "Leon Valley", "Leona", "Leonard", "Leroy", "Levelland", "Lewisville", "Lexington", "Liberty", "Liberty Hill", "Lincoln Park", "Lindale", "Linden", "Lindsay", "Lipan", "Little Elm", "Little River Academy", "Littlefield" };
                    string[] city2 = new[] { "Live Oak", "Liverpool", "Livingston", "Llano", "Lockhart", "Lockney", "Log Cabin", "Lometa", "Lone Oak", "Lone Star", "Longview", "Loraine", "Lorena", "Lorenzo", "Los Fresnos", "Los Indios", "Los Ybanez", "Lott", "Lovelady", "Lowry Crossing", "Lubbock", "Lucas", "Lueders", "Lufkin", "Luling", "Lumberton", "Lyford", "Lytle", "Mabank", "Madisonville", "Magnolia", "Malakoff", "Malone", "Manor", "Mansfield", "Manvel", "Marble Falls", "Marfa", "Marietta", "Marion", "Marlin", "Marquez", "Marshall", "Mart", "Martindale", "Mason", "Matador", "Mathis", "Maud", "Maypearl", "McAllen", "McCamey", "McGregor", "McKinney", "McLean", "McLendon-Chisholm", "Meadow", "Meadowlakes", "Meadows Place", "Megargel", "Melissa", "Melvin", "Memphis", "Menard", "Mercedes", "Meridian", "Merkel", "Mertens", "Mertzon", "Mesquite", "Mexia", "Miami", "Midland", "Midlothian", "Midway", "Milano", "Mildred", "Miles", "Milford", "Miller's Cove", "Millsap", "Mineola", "Mineral Wells", "Mingus", "Mission", "Missouri City", "Mobeetie", "Mobile City", "Monahans", "Mont Belvieu", "Montgomery", "Moody", "Moore Station", "Moran", "Morgan", "Morgan's Point", "Morgan's Point Resort", "Morton", "Moulton", "Mount Calm", "Mount Enterprise", "Mount Pleasant", "Mount Vernon", "Mountain City", "Muenster", "Muleshoe", "Mullin", "Munday", "Murchison", "Murphy", "Mustang", "Mustang Ridge", "Nacogdoches", "Naples", "Nash", "Nassau Bay", "Natalia", "Navarro", "Navasota", "Nazareth", "Nederland", "Needville", "Nesbitt", "Nevada", "New Berlin", "New Boston", "New Braunfels", "New Chapel Hill", "New Deal", "New Fairview", "New Home", "New Hope", "New London", "New Summerfield", "New Waverly", "Newark", "Newcastle", "Newton", "Neylandville", "Niederwald", "Nixon", "Nocona", "Nolanville", "Nome", "Noonday", "Nordheim", "Normangee", "North Cleveland", "North Richland Hills", "Northlake", "Novice", "Oak Grove", "Oak Leaf", "Oak Point", "Oak Ridge (Cooke)", "Oak Ridge (Kaufman)", "Oak Ridge North", "Oak Valley", "Oakwood", "O'Brien", "Odem", "Odessa", "O'Donnell", "Oglesby", "Old River-Winfree", "Olmos Park", "Olney", "Olton", "Omaha", "Onalaska", "Opdyke West", "Orange", "Orange Grove", "Orchard", "Ore City", "Overton", "Ovilla", "Oyster Creek", "Paducah", "Paint Rock", "Palacios", "Palestine", "Palisades", "Palm Valley", "Palmer", "Palmhurst", "Palmview", "Pampa", "Panhandle", "Panorama Village", "Pantego", "Paradise", "Paris", "Parker", "Pasadena", "Pattison", "Patton Village", "Payne Springs", "Pearland", "Pearsall", "Pecan Gap", "Pecan Hill", "Pecos", "Pelican Bay", "Penelope", "Penitas", "Perryton", "Petersburg", "Petrolia", "Petronila", "Pflugerville", "Pharr", "Pilot Point", "Pine Forest", "Pine Island", "Pinehurst", "Pineland", "Piney Point Village", "Pittsburg", "Plains", "Plainview", "Plano", "Pleak", "Pleasant Valley", "Pleasanton", "Plum Grove", "Point", "Point Blank", "Point Comfort", "Point Venture", "Ponder", "Port Aransas", "Port Arthur", "Port Isabel", "Port Lavaca", "Port Neches", "Portland", "Post", "Post Oak Bend", "Poteet", "Poth", "Pottsboro", "Powell", "Poynor", "Prairie View", "Premont", "Presidio", "Primera", "Princeton", "Progreso", "Progreso Lakes", "Prosper", "Providence Village", "Putnam", "Pyote", "Quanah", "Queen City", "Quinlan", "Quintana", "Quitaque", "Quitman", "Ralls", "Rancho Viejo", "Ranger", "Rangerville", "Rankin", "Ransom Canyon", "Ravenna", "Raymondville", "Red Lick", "Red Oak", "Redwater", "Refugio", "Reklaw", "Reno (Lamar)", "Reno (Parker)", "Retreat", "Rhome", "Rice", "Richardson", "Richland", "Richland Hills", "Richland Springs", "Richmond", "Richwood", "Riesel", "Rio Bravo", "Rio Grande City", "Rio Hondo", "Rio Vista", "Rising Star", "River Oaks", "Riverside", "Roanoke", "Roaring Springs", "Robert Lee", "Robinson", "Robstown", "Roby", "Rochester", "Rockdale", "Rockport", "Rocksprings", "Rockwall", "Rocky Mound", "Rogers", "Rollingwood", "Roma", "Roman Forest", "Ropesville", "Roscoe", "Rose City", "Rose Hill Acres", "Rosebud", "Rosenberg", "Ross", "Rosser", "Rotan", "Round Mountain", "Round Rock", "Round Top", "Rowlett", "Roxton", "Royse City", "Rule", "Runaway Bay", "Runge", "Rusk", "Sabinal", "Sachse", "Sadler", "Saginaw", "Saint Hedwig", "Saint Jo", "Saint Paul", "Salado", "San Angelo", "San Antonio", "San Augustine", "San Benito", "San Diego", "San Felipe", "San Juan", "San Leanna", "San Marcos", "San Patricio", "San Perlita", "San Saba", "Sanctuary", "Sandy Point", "Sanford", "Sanger", "Sansom Park", "Santa Anna", "Santa Clara", "Santa Fe", "Santa Rosa", "Savoy", "Schertz", "Schulenburg", "Scotland", "Scottsville", "Scurry", "Seabrook", "Seadrift", "Seagoville", "Seagraves", "Sealy", "Seguin", "Selma", "Seminole", "Seven Oaks", "Seven Points", "Seymour", "Shady Shores", "Shallowater", "Shamrock", "Shavano Park", "Shenandoah", "Shepherd", "Sherman", "Shiner", "Shoreacres", "Silsbee", "Silverton", "Simonton", "Sinton", "Skellytown", "Slaton", "Smiley", "Smithville", "Smyer", "Snook", "Snyder", "Socorro", "Somerset", "Somerville", "Sonora", "Sour Lake", "South Houston", "South Mountain", "South Padre Island", "Southlake", "Southmayd", "Southside Place", "Spearman", "Splendora", "Spofford", "Spring Valley", "Springlake", "Springtown", "Spur", "Stafford", "Stagecoach", "Stamford", "Stanton", "Staples", "Star Harbor", "Stephenville", "Sterling City", "Stinnett", "Stockdale", "Stratford", "Strawn", "Streetman", "Sudan", "Sugar Land", "Sullivan City", "Sulphur Springs", "Sun Valley", "Sundown", "Sunnyvale", "Sunray", "Sunrise Beach Village", "Sunset Valley", "Surfside Beach", "Sweeny", "Sweetwater", "Taft", "Tahoka", "Talco", "Talty", "Tatum", "Taylor", "Taylor Lake Village", "Taylor Landing", "Teague", "Tehuacana", "Temple", "Tenaha", "Terrell", "Terrell Hills", "Texarkana", "Texas City", "Texhoma", "Texline", "The Colony", "Thompsons", "Thorndale", "Thornton", "Thorntonville", "Thrall", "Three Rivers", "Throckmorton", "Tiki Island", "Timbercreek Canyon", "Timpson", "Tioga", "Tira", "Toco", "Todd Mission", "Tolar", "Tom Bean", "Tomball", "Tool", "Toyah", "Trent", "Trenton", "Trinidad", "Trinity", "Trophy Club", "Troup", "Troy", "Tulia", "Turkey", "Tuscola", "Tye", "Tyler", "Uhland", "Uncertain", "Union Grove", "Union Valley", "Universal City", "University Park", "Uvalde", "Valentine", "Valley Mills", "Valley View", "Van", "Van Alstyne", "Van Horn", "Vega", "Venus", "Vernon", "Victoria", "Vidor", "Village of The Hills", "Villiage of Volente", "Vinton", "Von Ormy", "Waco", "Waelder", "Wake Village", "Waller", "Wallis", "Walnut Springs", "Warren City", "Waskom", "Watauga", "Waxahachie", "Weatherford", "Webberville", "Webster", "Weimar", "Weinert", "Weir", "Wellington", "Wellman", "Wells", "Weslaco", "West", "West Columbia", "West Lake Hills", "West Orange", "West Tawakoni", "West University Place", "Westbrook", "Westlake", "Weston", "Weston Lakes", "Westover Hills", "Westworth Village", "Wharton", "Wheeler", "White Deer", "White Oak", "White Settlement", "Whiteface", "Whitehouse", "Whitesboro", "Whitewright", "Whitney", "Wichita Falls", "Wickett", "Willis", "Willow Park", "Wills Point", "Wilmer", "Wilson", "Wimberley", "Windcrest", "Windom", "Windthorst", "Winfield", "Wink", "Winnsboro", "Winona", "Winters", "Wixon Valley", "Wolfe City", "Wolfforth", "Woodbranch Village", "Woodcreek", "Woodloch", "Woodsboro", "Woodson", "Woodville", "Woodway", "Wortham", "Wylie", "Yantis", "Yoakum", "Yorktown", "Zavalla" };
                    string[] cityls = new string[city1.Length + city2.Length];
                    city1.CopyTo(cityls, 0);
                    city2.CopyTo(cityls, city1.Length);
                    
                        foreach (string cityst in cityls)
                        {
                            city.Items.Add(cityst);
                        }
                    
                    WebEOCApi.API api = new WebEOCApi.API();

                    string[] listOfIncidents = api.GetIncidents(creds(""));
                    int selected = 0;
             
                        foreach (string incident in listOfIncidents)
                        {
                            string[] number = incident.Split(' ');
                            var numberStr = number[0].Replace("-", "");
                            if (Session["pin"] != null && Session["pin"].ToString() == numberStr)
                            {
                                selected = webeocIncident.Items.Count;
                                webeocIncident.Enabled = false;
                            }
                            webeocIncident.Items.Add(incident);
                        }

                        webeocIncident.SelectedIndex = selected;
                 
                    string[] types = new[] { "Select One", "Chemical/Biological", "Coastal Storm", "Dam/Levee Break", "Drought", "Earthquake", "Emergency Planning and Security", "Explosions", "Extreme Temperatures", "Fire", "Flooding", "Hurricane/Tropical Storm", "Industry Hardship", "Mudslide and Landslide", "Radiation Leak", "Severe Storms", "Snow Storm", "Straight-line Winds", "Technological", "Terrorism", "Tornadoes", "Tsunami", "Typhoon", "Virus Threat", "Volcano", "Wildfire", "Winter Storms" };
                    foreach (string t in types)
                    {
                        type.Items.Add(t);
                    }
                }
                if (Session["updateNumber"] != null && Session["updateNumber"] != "")
                {
                    loadUpdateForm(Session["updateNumber"].ToString());
                }
            }
        }
        protected void loadUpdateForm(string dataid)
        {
            WebEOCApi.API api = new WebEOCApi.API();
            string boardName = "TDEM(F) - DSO";
            string viewName = "API DSO Detail (DO NOT ASSIGN)";
            string results = api.GetDataByDataId(creds(webeocIncident.SelectedValue), boardName, viewName,int.Parse(dataid));
            XmlDocument xDoc = new XmlDocument();
            xDoc.LoadXml(results);
            var records = xDoc.SelectNodes("data/record");
            var element = (XmlElement)records[0];
            if (element.Attributes.Count<=6) { Response.Redirect("error.aspx?errorCode=101"); return; }
            UpdateFillDropdown(webeocIncident,element.Attributes["webeocIncident"].Value);
            UpdateFillCheckBox(jurisdictionType1, jurisdictionType2, element.Attributes["jurisdictionType"].Value);
            county.SelectedIndex = county.Items.IndexOf(county.Items.FindByValue(element.Attributes["county"].Value));
            UpdateFillList(city,element.Attributes["city"].Value);
            population.Text = element.Attributes["population"].Value;
            UpdateFillList(type, element.Attributes["type"].Value);
            UpdateFillCheckBox(nfip1,nfip2,element.Attributes["nfip"].Value);
            dateOfDisaster1.Text = element.Attributes["dateOfDisaster1"].Value;
            dateOfDisaster2.Text = element.Attributes["dateOfDisaster2"].Value;
            if (element.Attributes["continuing"].Value == "Continuing")
            {
                continuing.Checked=true;
            }
            UpdateFillCheckBox(declarationIssued1,declarationIssued2,element.Attributes["declarationIssued"].Value);
            contactPerson.Text = element.Attributes["contactPerson"].Value;
            contactPersonTitle.Text = element.Attributes["contactPersonTitle"].Value;
            address.Text = element.Attributes["address"].Value;
            phone.Text = element.Attributes["phone"].Value;
            mobilePhone.Text = element.Attributes["mobilePhone"].Value;
            fax.Text = element.Attributes["fax"].Value;
            pager.Text = element.Attributes["pager"].Value;
            dutyPhone.Text = element.Attributes["dutyPhone"].Value;
            sfhAffected.Text = element.Attributes["sfhAffected"].Value;
            sfhMinorDamage.Text = element.Attributes["sfhMinorDamage"].Value;
            sfhMajorDamage.Text = element.Attributes["sfhMajorDamage"].Value;
            sfhDestroyed.Text = element.Attributes["sfhDestroyed"].Value;
            sfhCovByInsurance.Text = element.Attributes["sfhCovByInsurance"].Value;
            mhAffected.Text = element.Attributes["mhAffected"].Value;
            mhMinorDamage.Text = element.Attributes["mhMinorDamage"].Value;
            mhMajorDamage.Text = element.Attributes["mhMajorDamage"].Value;
            mhDestroyed.Text = element.Attributes["mhDestroyed"].Value;
            mhCovByInsurance.Text = element.Attributes["mhCovByInsurance"].Value;
            mfuAffected.Text = element.Attributes["mfuAffected"].Value;
            mfuMinorDamage.Text = element.Attributes["mfuMinorDamage"].Value;
            mfuMajorDamage.Text = element.Attributes["mfuMajorDamage"].Value;
            mfuDestroyed.Text = element.Attributes["mfuDestroyed"].Value;
            mfuCovByInsurance.Text = element.Attributes["mfuCovByInsurance"].Value;
            totalsAffected.Text = element.Attributes["totalsAffected"].Value;
            totalsMinorDamage.Text = element.Attributes["totalsMinorDamage"].Value;
            totalsMajorDamage.Text = element.Attributes["totalsMajorDamage"].Value;
            totalsDestroyed.Text = element.Attributes["totalsDestroyed"].Value;
            totalsCovByInsurance.Text = element.Attributes["totalsCovByInsurance"].Value;
            homesIsolated.Text = element.Attributes["homesIsolated"].Value;
            numberMinorDamage.Text = element.Attributes["numberMinorDamage"].Value;
            coveredMinorDamage.Text = element.Attributes["coveredMinorDamage"].Value;
            totalMinorDamage.Text = element.Attributes["totalMinorDamage"].Value;
            numberMajorDamage.Text = element.Attributes["numberMajorDamage"].Value;
            coveredMajorDamage.Text = element.Attributes["coveredMajorDamage"].Value;
            totalMajorDamage.Text = element.Attributes["totalMajorDamage"].Value;
            numberTotal.Text = element.Attributes["numberTotal"].Value;
            coveredTotal.Text = element.Attributes["coveredTotal"].Value;
            totalTotal.Text = element.Attributes["totalTotal"].Value;
            businessesCeased.Text = element.Attributes["businessesCeased"].Value;
            businessesEconomicInjury.Text = element.Attributes["businessesEconomicInjury"].Value;
            numberUnemployed.Text = element.Attributes["numberUnemployed"].Value;
            sitesDebrisClearance.Text = element.Attributes["sitesDebrisClearance"].Value;
            repairCostDebrisClearance.Text = element.Attributes["repairCostDebrisClearance"].Value;
            insuranceDebrisClearance.Text = element.Attributes["insuranceDebrisClearance"].Value;
            sitesEmergency.Text = element.Attributes["sitesEmergency"].Value;
            repairCostEmergency.Text = element.Attributes["repairCostEmergency"].Value;
            insuranceEmergency.Text = element.Attributes["insuranceEmergency"].Value;
            sitesRoadPaved.Text = element.Attributes["sitesRoadPaved"].Value;
            repairCostRoadPaved.Text = element.Attributes["repairCostRoadPaved"].Value;
            insuranceRoadPaved.Text = element.Attributes["insuranceRoadPaved"].Value;
            sitesWaterControlFacilities.Text = element.Attributes["sitesWaterControlFacilities"].Value;
            repairCostWaterControlFacilities.Text = element.Attributes["repairCostWaterControlFacilities"].Value;
            insuranceWaterControlFacilities.Text = element.Attributes["insuranceWaterControlFacilities"].Value;
            sitesBuildingsEquipment.Text = element.Attributes["sitesBuildingsEquipment"].Value;
            repairCostBuildingsEquipment.Text = element.Attributes["repairCostBuildingsEquipment"].Value;
            insuranceBuildingsEquipment.Text = element.Attributes["insuranceBuildingsEquipment"].Value;
            sitesUtilitySystems.Text = element.Attributes["sitesUtilitySystems"].Value;
            repairCostUtilitySystems.Text = element.Attributes["repairCostUtilitySystems"].Value;
            insuranceUtilitySystems.Text = element.Attributes["insuranceUtilitySystems"].Value;
            sitesOther.Text = element.Attributes["sitesOther"].Value;
            repairCostOther.Text = element.Attributes["repairCostOther"].Value;
            insuranceOther.Text = element.Attributes["insuranceOther"].Value;
            sitesTotals.Text = element.Attributes["sitesTotals"].Value;
            repairCostTotals.Text = element.Attributes["repairCostTotals"].Value;
            insuranceTotals.Text = element.Attributes["insuranceTotals"].Value;
            annualMaintenanceBudget.Text = element.Attributes["annualMaintenanceBudget"].Value;
            startOfFiscalYear.Text = element.Attributes["startOfFiscalYear"].Value;
            orgFacility01.Text = element.Attributes["orgFacility01"].Value;
            sites01.Text = element.Attributes["sites01"].Value;
            repairCost01.Text = element.Attributes["repairCost01"].Value;
            insurance01.Text = element.Attributes["insurance01"].Value;
            orgFacility02.Text = element.Attributes["orgFacility02"].Value;
            sites02.Text = element.Attributes["sites02"].Value;
            repairCost02.Text = element.Attributes["repairCost02"].Value;
            insurance02.Text = element.Attributes["insurance02"].Value;
            orgFacility03.Text = element.Attributes["orgFacility03"].Value;
            sites03.Text = element.Attributes["sites03"].Value;
            repairCost03.Text = element.Attributes["repairCost03"].Value;
            insurance03.Text = element.Attributes["insurance03"].Value;
            orgFacility04.Text = element.Attributes["orgFacility04"].Value;
            sites04.Text = element.Attributes["sites04"].Value;
            repairCost04.Text = element.Attributes["repairCost04"].Value;
            insurance04.Text = element.Attributes["insurance04"].Value;
            orgFacility05.Text = element.Attributes["orgFacility05"].Value;
            sites05.Text = element.Attributes["sites05"].Value;
            repairCost05.Text = element.Attributes["repairCost05"].Value;
            insurance05.Text = element.Attributes["insurance05"].Value;
            orgFacility06.Text = element.Attributes["orgFacility06"].Value;
            sites06.Text = element.Attributes["sites06"].Value;
            repairCost06.Text = element.Attributes["repairCost06"].Value;
            insurance06.Text = element.Attributes["insurance06"].Value;
            orgFacility07.Text = element.Attributes["orgFacility07"].Value;
            sites07.Text = element.Attributes["sites07"].Value;
            repairCost07.Text = element.Attributes["repairCost07"].Value;
            insurance07.Text = element.Attributes["insurance07"].Value;
            orgFacility08.Text = element.Attributes["orgFacility08"].Value;
            sites08.Text = element.Attributes["sites08"].Value;
            repairCost08.Text = element.Attributes["repairCost08"].Value;
            insurance08.Text = element.Attributes["insurance08"].Value;
            orgFacility09.Text = element.Attributes["orgFacility09"].Value;
            sites09.Text = element.Attributes["sites09"].Value;
            repairCost09.Text = element.Attributes["repairCost09"].Value;
            insurance09.Text = element.Attributes["insurance09"].Value;
            orgFacility10.Text = element.Attributes["orgFacility10"].Value;
            sites10.Text = element.Attributes["sites10"].Value;
            repairCost10.Text = element.Attributes["repairCost10"].Value;
            insurance10.Text = element.Attributes["insurance10"].Value;
            orgFacility11.Text = element.Attributes["orgFacility11"].Value;
            sites11.Text = element.Attributes["sites11"].Value;
            repairCost11.Text = element.Attributes["repairCost11"].Value;
            insurance11.Text = element.Attributes["insurance11"].Value;
            orgFacility12.Text = element.Attributes["orgFacility12"].Value;
            sites12.Text = element.Attributes["sites12"].Value;
            repairCost12.Text = element.Attributes["repairCost12"].Value;
            insurance12.Text = element.Attributes["insurance12"].Value;
            orgFacility13.Text = element.Attributes["orgFacility13"].Value;
            sites13.Text = element.Attributes["sites13"].Value;
            repairCost13.Text = element.Attributes["repairCost13"].Value;
            insurance13.Text = element.Attributes["insurance13"].Value;
            orgFacility14.Text = element.Attributes["orgFacility14"].Value;
            sites14.Text = element.Attributes["sites14"].Value;
            repairCost14.Text = element.Attributes["repairCost14"].Value;
            insurance14.Text = element.Attributes["insurance14"].Value;
            orgFacility15.Text = element.Attributes["orgFacility15"].Value;
            sites15.Text = element.Attributes["sites15"].Value;
            repairCost15.Text = element.Attributes["repairCost15"].Value;
            insurance15.Text = element.Attributes["insurance15"].Value;
            sitesOtherTotal.Text = element.Attributes["sitesOtherTotal"].Value;
            repairCostTotal.Text = element.Attributes["repairCostTotal"].Value;
            insuranceCostTotal.Text = element.Attributes["insuranceCostTotal"].Value;
            submitterName.Text = element.Attributes["submitterName"].Value;
            submitterEmail.Text = element.Attributes["submitterEmail"].Value;
            UpdateFillDropdown(cat01, element.Attributes["cat01"].Value);
            UpdateFillDropdown(cat02, element.Attributes["cat02"].Value);
            UpdateFillDropdown(cat03, element.Attributes["cat03"].Value);
            UpdateFillDropdown(cat04, element.Attributes["cat04"].Value);
            UpdateFillDropdown(cat05, element.Attributes["cat05"].Value);
            UpdateFillDropdown(cat06, element.Attributes["cat06"].Value);
            UpdateFillDropdown(cat07, element.Attributes["cat07"].Value);
            UpdateFillDropdown(cat08, element.Attributes["cat08"].Value);
            UpdateFillDropdown(cat09, element.Attributes["cat09"].Value);
            UpdateFillDropdown(cat10, element.Attributes["cat10"].Value);
            UpdateFillDropdown(cat11, element.Attributes["cat11"].Value);
            UpdateFillDropdown(cat12, element.Attributes["cat12"].Value);
            UpdateFillDropdown(cat13, element.Attributes["cat13"].Value);
            UpdateFillDropdown(cat14, element.Attributes["cat14"].Value);
            UpdateFillDropdown(cat15, element.Attributes["cat15"].Value);
            additionalEmails.Text=element.Attributes["additionalEmails"].Value;
            notes.Text = element.Attributes["notes"].Value;
            try
            {
                if (element.Attributes["dsoDisable"].Value == "Yes")
                {
                    saveCmd.Enabled = false;
                    saveCmd.Text = "Editing Disabled By SOC";

                }
            }
            catch (Exception) { 
            
            }
            }

        protected void UpdateFillList(ListBox list, string values) {
            string[] valuesSplit = values.Split(',');
            foreach (ListItem item in list.Items)
            {
                foreach (var newitems in valuesSplit)
                {
                    if (item.Text == newitems.Trim())
                    {
                        item.Selected = true;
                    }

                }
            }
        }
        protected void UpdateFillDropdown(DropDownList list, string values)
        {
            string[] valuesSplit = values.Split(',');
            foreach (ListItem item in list.Items)
            {
                foreach (var newitems in valuesSplit)
                {
                    if (item.Text == newitems.Trim())
                    {
                        item.Selected = true;
                    }
                    else {
                        item.Selected = false;
                    }
                }
            }
        }
        protected void UpdateFillCheckBox(CheckBox box1, CheckBox box2, string value) {
            if (value == box1.Text)
            {
                box1.Checked = true;
            }
            if (value == box2.Text)
            {
                box2.Checked = true;
            }
        
        }
        protected WebEOCApi.WebEOCCredentials creds(string Incident) {
            WebEOCApi.WebEOCCredentials creds = new WebEOCApi.WebEOCCredentials();
            creds.Username = "API-DSO";
            creds.Password = "9MLkIRRpY2v2";
            creds.Position = "API-DSO";
            if (Incident != "")
            {
                creds.Incident = Incident;
            }
            return creds;
        }
        protected void cancelBttn_Click(object sender, EventArgs e)
        {
            Session["pin"] = "";
            Session["entryType"] = "";
            Response.Redirect("Default.aspx");
        }
        protected void saveCmd_Click(object sender, EventArgs e)
        {
            string hidden = "";
            string entryType = "";
            if (Session["entryType"] != null && Session["entryType"] == "Live")
            {
                entryType = "Live";
            }
            if (Session["entryType"] != null && Session["entryType"] == "Training")
            {
                entryType = "Training";
                hidden = "Yes";
            }


            WebEOCApi.API api = new WebEOCApi.API();
            string cities = "";

            for (var i = 0; i < city.Items.Count; i++)
            {
                if (city.Items[i].Selected == true)
                {
                    cities += city.Items[i].ToString() + ", ";
                }
            }
            string types = "";

            for (var i = 0; i < type.Items.Count; i++)
            {
                if (type.Items[i].Selected == true)
                {
                    types += type.Items[i].ToString() + ", ";
                }
            }
            string juristictionFor ="";
           string radioJurisdictionType = "";
           if (jurisdictionType1.Checked == true) { radioJurisdictionType = "City"; juristictionFor = cities; } else if (jurisdictionType2.Checked == true) { radioJurisdictionType = "County"; juristictionFor = county.SelectedItem.Text; } else { radioJurisdictionType = ""; };
            string radioNfip ="";
             if(nfip1.Checked==true){radioNfip = "Yes";} else if(nfip2.Checked==true){radioNfip = "City";}else{radioNfip = "";};
            string radioDeclarationIssued = "";
            if(declarationIssued1.Checked==true){radioDeclarationIssued = "Yes";} else if(declarationIssued2.Checked==true){radioDeclarationIssued = "City";}else{radioDeclarationIssued = "";};
           /* string radioAgricultural = "";
            if(agricultural1.Checked==true){radioAgricultural = "Yes";} else if(agricultural2.Checked==true){radioAgricultural = "City";}else{radioAgricultural = "";};*/
            /*string radioSheltersOpen="";
            if(sheltersOpen1.Checked==true){radioSheltersOpen = "Yes";} else if(sheltersOpen2.Checked==true){radioSheltersOpen = "City";}else{radioSheltersOpen = "";};*/
            string checkboxContinuing = "";
            if (continuing.Checked == true) { checkboxContinuing = "Yes"; };


            string boardName = "TDEM(F) - DSO";
            string inputViewName = "API DSO Input (DO NOT ASSIGN)";
            string xmlfilter ="";
            if (radioJurisdictionType == "City")
            {
                xmlfilter = "<data><hidden></hidden><jurisdictionType>" + radioJurisdictionType + "</jurisdictionType><county>" + county.SelectedItem.Text + "</county><city>" + cities + "</city></data>";
            }
            else {
                xmlfilter = "<data><hidden></hidden><jurisdictionType>" + radioJurisdictionType + "</jurisdictionType><county>" + county.SelectedItem.Text + "</county></data>";

            }
            string results = api.GetFilteredData(creds(webeocIncident.SelectedValue), boardName, "API Unique Check (DO NOT ASSIGN)", null, xmlfilter);
            XmlDocument xDoc = new XmlDocument();
            xDoc.LoadXml(results);
            var records = xDoc.SelectNodes("data/record");
            int numberOfRecords = records.Count;
            int updateDataId = 0;
            if (numberOfRecords > 0)
            {
                var element = (XmlElement)records[0];
                updateDataId = int.Parse(element.Attributes["dataid"].Value);
            }
            //check to see if summary is alreadey there
            /*if (radioJurisdictionType == "City")
            {
                xmlfilter = "<data><hide></hide><jurisdictionType>" + radioJurisdictionType + "</jurisdictionType><county>" + county.SelectedItem.Text + "</county><city>" + cities + "</city></data>";
            }
            else
            {
                xmlfilter = "<data><hide></hide><jurisdictionType>" + radioJurisdictionType + "</jurisdictionType><county>" + county.SelectedItem.Text + "</county></data>";

            }
            results = api.GetFilteredData(creds(webeocIncident.SelectedValue), boardName, "API Unique Check  Bubble (DO NOT ASSIGN)", null, xmlfilter);
            xDoc = new XmlDocument();
            xDoc.LoadXml(results);
            records = xDoc.SelectNodes("data/record");
           int numberOfBubbleRecords = records.Count;
           int updateBubbleDataId = 0;
            if (numberOfBubbleRecords > 0)
            {
                var element = (XmlElement)records[0];
                updateBubbleDataId = int.Parse(element.Attributes["dataid"].Value);
               
            }
            */
            //End

            string updated = "No";
            if (Session["updateNumber"] != null && Session["updateNumber"] != "")
            {
                updated = "Yes";
            }
           /* if (updateDataId == 0)
            {
                updated = "No";
            }
            else {
                updated = "Yes";
            }
            */
            
            string xmlData = "<data>" +
"<webeocIncident>"+webeocIncident.SelectedValue+"</webeocIncident>" +
"<jurisdictionType>" + radioJurisdictionType + "</jurisdictionType>" +
"<county>" + county.SelectedItem.Text + "</county>" +
"<city>" + cities + "</city>" +
"<type>" + types + "</type>" +
"<nfip>" + radioNfip + "</nfip>" +
"<dateOfDisaster1>" + dateOfDisaster1.Text.ToString() + "</dateOfDisaster1>" +
"<dateOfDisaster2>" + dateOfDisaster2.Text.ToString() + "</dateOfDisaster2>" +
"<declarationIssued>" + radioDeclarationIssued + "</declarationIssued>" +
"<contactPerson>" + contactPerson.Text.ToString() + "</contactPerson>" +
"<address>" + address.Text.ToString() + "</address>" +
"<phone>" + phone.Text.ToString() + "</phone>" +
"<fax>" + fax.Text.ToString() + "</fax>" +
"<pager>" + pager.Text.ToString() + "</pager>" +
"<dutyPhone>" + dutyPhone.Text.ToString() + "</dutyPhone>" +
/*"<fatalities>" + fatalities.Text.ToString() + "</fatalities>" +
"<injuries>" + injuries.Text.ToString() + "</injuries>" +
"<hospitalized>" + hospitalized.Text.ToString() + "</hospitalized>" +*/
/*"<agricultural>" + radioAgricultural + "</agricultural>" +*/
"<sfhAffected>" + sfhAffected.Text.ToString() + "</sfhAffected>" +
"<sfhMinorDamage>" + sfhMinorDamage.Text.ToString() + "</sfhMinorDamage>" +
"<sfhMajorDamage>" + sfhMajorDamage.Text.ToString() + "</sfhMajorDamage>" +
"<sfhDestroyed>" + sfhDestroyed.Text.ToString() + "</sfhDestroyed>" +
"<sfhCovByInsurance>" + sfhCovByInsurance.Text.ToString() + "</sfhCovByInsurance>" +
"<mhAffected>" + mhAffected.Text.ToString() + "</mhAffected>" +
"<mhMinorDamage>" + mhMinorDamage.Text.ToString() + "</mhMinorDamage>" +
"<mhMajorDamage>" + mhMajorDamage.Text.ToString() + "</mhMajorDamage>" +
"<mhDestroyed>" + mhDestroyed.Text.ToString() + "</mhDestroyed>" +
"<mhCovByInsurance>" + mhCovByInsurance.Text.ToString() + "</mhCovByInsurance>" +
"<mfuAffected>" + mfuAffected.Text.ToString() + "</mfuAffected>" +
"<mfuMinorDamage>" + mfuMinorDamage.Text.ToString() + "</mfuMinorDamage>" +
"<mfuMajorDamage>" + mfuMajorDamage.Text.ToString() + "</mfuMajorDamage>" +
"<mfuDestroyed>" + mfuDestroyed.Text.ToString() + "</mfuDestroyed>" +
"<mfuCovByInsurance>" + mfuCovByInsurance.Text.ToString() + "</mfuCovByInsurance>" +
"<totalsAffected>" + totalsAffected.Text.ToString() + "</totalsAffected>" +
"<totalsMinorDamage>" + totalsMinorDamage.Text.ToString() + "</totalsMinorDamage>" +
"<totalsMajorDamage>" + totalsMajorDamage.Text.ToString() + "</totalsMajorDamage>" +
"<totalsDestroyed>" + totalsDestroyed.Text.ToString() + "</totalsDestroyed>" +
"<totalsCovByInsurance>" + totalsCovByInsurance.Text.ToString() + "</totalsCovByInsurance>" +
/*"<numNotSatisfiedByVolunteers>" + numNotSatisfiedByVolunteers.Text.ToString() + "</numNotSatisfiedByVolunteers>" +*/
/*"<sheltersOpen>" + radioSheltersOpen + "</sheltersOpen>" +*/
/*"<sheltersHowMany>" + sheltersHowMany.Text.ToString() + "</sheltersHowMany>" +*/
/*"<shelterDetails>" + shelterDetails.Text.ToString() + "</shelterDetails>" +*/
"<numberMinorDamage>" + numberMinorDamage.Text.ToString() + "</numberMinorDamage>" +
"<coveredMinorDamage>" + coveredMinorDamage.Text.ToString() + "</coveredMinorDamage>" +
"<totalMinorDamage>" + totalMinorDamage.Text.ToString() + "</totalMinorDamage>" +
"<numberMajorDamage>" + numberMajorDamage.Text.ToString() + "</numberMajorDamage>" +
"<coveredMajorDamage>" + coveredMajorDamage.Text.ToString() + "</coveredMajorDamage>" +
"<totalMajorDamage>" + totalMajorDamage.Text.ToString() + "</totalMajorDamage>" +
"<numberTotal>" + numberTotal.Text.ToString() + "</numberTotal>" +
"<coveredTotal>" + coveredTotal.Text.ToString() + "</coveredTotal>" +
"<totalTotal>" + totalTotal.Text.ToString() + "</totalTotal>" +
"<businessesCeased>" + businessesCeased.Text.ToString() + "</businessesCeased>" +
"<businessesEconomicInjury>" + businessesEconomicInjury.Text.ToString() + "</businessesEconomicInjury>" +
"<numberUnemployed>" + numberUnemployed.Text.ToString() + "</numberUnemployed>" +
"<sitesDebrisClearance>" + sitesDebrisClearance.Text.ToString() + "</sitesDebrisClearance>" +
"<repairCostDebrisClearance>" + repairCostDebrisClearance.Text.ToString() + "</repairCostDebrisClearance>" +
"<insuranceDebrisClearance>" + insuranceDebrisClearance.Text.ToString() + "</insuranceDebrisClearance>" +
"<sitesEmergency>" + sitesEmergency.Text.ToString() + "</sitesEmergency>" +
"<repairCostEmergency>" + repairCostEmergency.Text.ToString() + "</repairCostEmergency>" +
"<insuranceEmergency>" + insuranceEmergency.Text.ToString() + "</insuranceEmergency>" +
"<sitesRoadPaved>" + sitesRoadPaved.Text.ToString() + "</sitesRoadPaved>" +
"<repairCostRoadPaved>" + repairCostRoadPaved.Text.ToString() + "</repairCostRoadPaved>" +
"<insuranceRoadPaved>" + insuranceRoadPaved.Text.ToString() + "</insuranceRoadPaved>" +
"<sitesWaterControlFacilities>" + sitesWaterControlFacilities.Text.ToString() + "</sitesWaterControlFacilities>" +
"<repairCostWaterControlFacilities>" + repairCostWaterControlFacilities.Text.ToString() + "</repairCostWaterControlFacilities>" +
"<insuranceWaterControlFacilities>" + insuranceWaterControlFacilities.Text.ToString() + "</insuranceWaterControlFacilities>" +
"<sitesBuildingsEquipment>" + sitesBuildingsEquipment.Text.ToString() + "</sitesBuildingsEquipment>" +
"<repairCostBuildingsEquipment>" + repairCostBuildingsEquipment.Text.ToString() + "</repairCostBuildingsEquipment>" +
"<insuranceBuildingsEquipment>" + insuranceBuildingsEquipment.Text.ToString() + "</insuranceBuildingsEquipment>" +
"<sitesUtilitySystems>" + sitesUtilitySystems.Text.ToString() + "</sitesUtilitySystems>" +
"<repairCostUtilitySystems>" + repairCostUtilitySystems.Text.ToString() + "</repairCostUtilitySystems>" +
"<insuranceUtilitySystems>" + insuranceUtilitySystems.Text.ToString() + "</insuranceUtilitySystems>" +
"<sitesOther>" + sitesOther.Text.ToString() + "</sitesOther>" +
"<repairCostOther>" + repairCostOther.Text.ToString() + "</repairCostOther>" +
"<insuranceOther>" + insuranceOther.Text.ToString() + "</insuranceOther>" +
"<sitesTotals>" + sitesTotals.Text.ToString() + "</sitesTotals>" +
"<repairCostTotals>" + repairCostTotals.Text.ToString() + "</repairCostTotals>" +
"<insuranceTotals>" + insuranceTotals.Text.ToString() + "</insuranceTotals>" +
"<annualMaintenanceBudget>" + annualMaintenanceBudget.Text.ToString() + "</annualMaintenanceBudget>" +
"<startOfFiscalYear>" + startOfFiscalYear.Text.ToString() + "</startOfFiscalYear>" +
"<orgFacility01>" + orgFacility01.Text.ToString() + "</orgFacility01>" +
"<sites01>" + sites01.Text.ToString() + "</sites01>" +
"<repairCost01>" + repairCost01.Text.ToString() + "</repairCost01>" +
"<insurance01>" + insurance01.Text.ToString() + "</insurance01>" +
"<orgFacility02>" + orgFacility02.Text.ToString() + "</orgFacility02>" +
"<sites02>" + sites02.Text.ToString() + "</sites02>" +
"<repairCost02>" + repairCost02.Text.ToString() + "</repairCost02>" +
"<insurance02>" + insurance02.Text.ToString() + "</insurance02>" +
"<orgFacility03>" + orgFacility03.Text.ToString() + "</orgFacility03>" +
"<sites03>" + sites03.Text.ToString() + "</sites03>" +
"<repairCost03>" + repairCost03.Text.ToString() + "</repairCost03>" +
"<insurance03>" + insurance03.Text.ToString() + "</insurance03>" +
"<orgFacility04>" + orgFacility04.Text.ToString() + "</orgFacility04>" +
"<sites04>" + sites04.Text.ToString() + "</sites04>" +
"<repairCost04>" + repairCost04.Text.ToString() + "</repairCost04>" +
"<insurance04>" + insurance04.Text.ToString() + "</insurance04>" +
"<orgFacility05>" + orgFacility05.Text.ToString() + "</orgFacility05>" +
"<sites05>" + sites05.Text.ToString() + "</sites05>" +
"<repairCost05>" + repairCost05.Text.ToString() + "</repairCost05>" +
"<insurance05>" + insurance05.Text.ToString() + "</insurance05>" +
"<orgFacility06>" + orgFacility06.Text.ToString() + "</orgFacility06>" +
"<sites06>" + sites06.Text.ToString() + "</sites06>" +
"<repairCost06>" + repairCost06.Text.ToString() + "</repairCost06>" +
"<insurance06>" + insurance06.Text.ToString() + "</insurance06>" +
"<orgFacility07>" + orgFacility07.Text.ToString() + "</orgFacility07>" +
"<sites07>" + sites07.Text.ToString() + "</sites07>" +
"<repairCost07>" + repairCost07.Text.ToString() + "</repairCost07>" +
"<insurance07>" + insurance07.Text.ToString() + "</insurance07>" +
"<orgFacility08>" + orgFacility08.Text.ToString() + "</orgFacility08>" +
"<sites08>" + sites08.Text.ToString() + "</sites08>" +
"<repairCost08>" + repairCost08.Text.ToString() + "</repairCost08>" +
"<insurance08>" + insurance08.Text.ToString() + "</insurance08>" +
"<orgFacility09>" + orgFacility09.Text.ToString() + "</orgFacility09>" +
"<sites09>" + sites09.Text.ToString() + "</sites09>" +
"<repairCost09>" + repairCost09.Text.ToString() + "</repairCost09>" +
"<insurance09>" + insurance09.Text.ToString() + "</insurance09>" +
"<orgFacility10>" + orgFacility10.Text.ToString() + "</orgFacility10>" +
"<sites10>" + sites10.Text.ToString() + "</sites10>" +
"<repairCost10>" + repairCost10.Text.ToString() + "</repairCost10>" +
"<insurance10>" + insurance10.Text.ToString() + "</insurance10>" +
"<orgFacility11>" + orgFacility11.Text.ToString() + "</orgFacility11>" +
"<sites11>" + sites11.Text.ToString() + "</sites11>" +
"<repairCost11>" + repairCost11.Text.ToString() + "</repairCost11>" +
"<insurance11>" + insurance11.Text.ToString() + "</insurance11>" +
"<orgFacility12>" + orgFacility12.Text.ToString() + "</orgFacility12>" +
"<sites12>" + sites12.Text.ToString() + "</sites12>" +
"<repairCost12>" + repairCost12.Text.ToString() + "</repairCost12>" +
"<insurance12>" + insurance12.Text.ToString() + "</insurance12>" +
"<orgFacility13>" + orgFacility13.Text.ToString() + "</orgFacility13>" +
"<sites13>" + sites13.Text.ToString() + "</sites13>" +
"<repairCost13>" + repairCost13.Text.ToString() + "</repairCost13>" +
"<insurance13>" + insurance13.Text.ToString() + "</insurance13>" +
"<orgFacility14>" + orgFacility14.Text.ToString() + "</orgFacility14>" +
"<sites14>" + sites14.Text.ToString() + "</sites14>" +
"<repairCost14>" + repairCost14.Text.ToString() + "</repairCost14>" +
"<insurance14>" + insurance14.Text.ToString() + "</insurance14>" +
"<orgFacility15>" + orgFacility15.Text.ToString() + "</orgFacility15>" +
"<sites15>" + sites15.Text.ToString() + "</sites15>" +
"<repairCost15>" + repairCost15.Text.ToString() + "</repairCost15>" +
"<insurance15>" + insurance15.Text.ToString() + "</insurance15>" +
"<sitesOtherTotal>" + sitesOtherTotal.Text.ToString() + "</sitesOtherTotal>" +
"<repairCostTotal>" + repairCostTotal.Text.ToString() + "</repairCostTotal>" +
"<sitesOtherTotal>" + sitesOtherTotal.Text.ToString() + "</sitesOtherTotal>" +
"<submitterName>" + submitterName.Text.ToString() + "</submitterName>" +
"<submitterEmail>" + submitterEmail.Text.ToString() + "</submitterEmail>" +
"<sortCountyOrder>" + sortCountyOrder.Text.ToString() + "</sortCountyOrder>" +
"<sortCityOrder>" + sortCityOrder.Text.ToString() + "</sortCityOrder>" +
"<updated>" + updated + "</updated>" +
"<homesIsolated>" + homesIsolated.Text.ToString() + "</homesIsolated>" +
"<mobilePhone>" + mobilePhone.Text.ToString() + "</mobilePhone>"+
"<population>" +population.Text.ToString() + "</population>"+
"<submitedDateTime>"+DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss")+"</submitedDateTime>"+
"<continuing>" + checkboxContinuing + "</continuing>" +
"<notes>"+notes.Text+"</notes>"+
"<hidden>"+hidden+"</hidden>"+
"<contactPersonTitle>"+contactPersonTitle.Text.ToString()+"</contactPersonTitle>"+
"<cat01>"+cat01.SelectedValue+"</cat01>"+
"<cat02>" + cat02.SelectedValue + "</cat02>" +
"<cat03>" + cat03.SelectedValue + "</cat03>" +
"<cat04>" + cat04.SelectedValue + "</cat04>" +
"<cat05>" + cat05.SelectedValue + "</cat05>" +
"<cat06>" + cat06.SelectedValue + "</cat06>" +
"<cat07>" + cat07.SelectedValue + "</cat07>" +
"<cat08>" + cat08.SelectedValue + "</cat08>" +
"<cat09>" + cat09.SelectedValue + "</cat09>" +
"<cat10>" + cat10.SelectedValue + "</cat10>" +
"<cat11>" + cat11.SelectedValue + "</cat11>" +
"<cat12>" + cat12.SelectedValue + "</cat12>" +
"<cat13>" + cat13.SelectedValue + "</cat13>" +
"<cat14>" + cat14.SelectedValue + "</cat14>" +
"<cat15>" + cat15.SelectedValue + "</cat15>" +
"<additionalEmails>" + additionalEmails.Text + "</additionalEmails>" +
//"<countyEmail>" + countyEmail.Text + "</countyEmail>" + //WILL UNCOMMENT LATER
//"<ddcEmail>" + ddcEmail.Text + "</ddcEmail>" + //WILL UNCOMMENT LATER
"<entryType>" + entryType + "</entryType>" +
"<socProcessed>Not Processed</socProcessed>" +
"</data>";

           
               int dataid;
             /*  int olddateid;*/
            string emailwording="";
            if(Session["updateNumber"] != null && Session["updateNumber"] != "")
           /* {
                updated = "Yes";
            }
               if (updateDataId != 0)*/
               
               {
                   updateDataId = int.Parse(Session["updateNumber"].ToString());
                    dataid = api.UpdateData(creds(webeocIncident.SelectedValue), boardName, inputViewName, xmlData,updateDataId);
                    /*olddateid = api.UpdateData(creds(webeocIncident.SelectedValue), boardName, "API DSO Update","<data><hidden>Yes</hidden></data>", updateDataId);*/
                    emailwording = "An Updated ";
               }
               else
            {
                    dataid = api.AddData(creds(webeocIncident.SelectedValue), boardName, inputViewName, xmlData);
                   
                   emailwording = "A new ";
               }
            
             dataID.dataid = dataid;
             int setKeyAction = api.UpdateData(creds(webeocIncident.SelectedValue), boardName, "setKey (DO NOT ASSIGN)", "<data><editKey>" + dataid.ToString() + "</editKey></data>",dataid);  
             Session["dataid"] = dataid.ToString();
            //Add Attachments
/*if(usdaFlashReport.FileName!=""){
             byte[] attachmentFile = usdaFlashReport.FileBytes;

             api.AddAttachment(creds(webeocIncident.SelectedValue), boardName, inputViewName, "usdaFlashReport", dataid, attachmentFile, usdaFlashReport.FileName);
}*/
/*Audit Input*/
             int auditDataId;
             auditDataId = api.AddRelatedData(creds(webeocIncident.SelectedValue), boardName, "DSO Audit Input (DO NOT ASSIGN)", "<data><auditUser>Online Entry</auditUser><dateTime>" + DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "</dateTime><audit>" + audit.Text + "</audit></data>", "Core", dataid);
            /*
int bubbleDataId;
if (updateBubbleDataId != 0)
{
    bubbleDataId = api.UpdateData(creds(webeocIncident.SelectedValue), boardName, "Bubble Update (DO NOT ASSIGN)", "<data><updated>Yes</updated><jurisdictionType>" + radioJurisdictionType + "</jurisdictionType><county>" + county.SelectedItem.Text + "</county><city>" + cities + "</city></data>", updateBubbleDataId);
}
else {
    bubbleDataId = api.AddData(creds(webeocIncident.SelectedValue), boardName, "Bubble Input (DO NOT ASSIGN)", "<data><updated>No</updated><jurisdictionType>" + radioJurisdictionType + "</jurisdictionType><county>" + county.SelectedItem.Text + "</county><city>" + cities + "</city></data>");
}
            */
             if (submitterEmail.Text != "") {
                 string subject = "DSO for " + county.SelectedItem.Text + "/" + cities +"("+webeocIncident.Text+")";
                 string body = emailwording + 
                     "DSO # " + dataid.ToString() + " for " + county.SelectedItem.Text + "/" + cities + "("+webeocIncident.Text+")"+" has been submitted to the SOC. \n\n "+
                     "To update this request, go to https://olympus.soc.texas.gov/services/dso/default.aspx?key="+dataid.ToString() +"\n\n"+ 
                     "Please email soc@dps.texas.gov if you have any questions. \n\n"+
                     " DO NOT REPLY";
             sendEmail(submitterEmail.Text,subject,body);
             }
            //startOf: URL redirect if form submitted successfully
            Response.Redirect("Success.aspx");

        }

        public void sendEmail(string to, string subject, string body)
        {
            string newTo = to.Replace(" ", "");
            System.Net.Mail.MailMessage msg = new System.Net.Mail.MailMessage();
            msg.To.Add(newTo);
            msg.CC.Add("soc@dps.texas.gov");
            if (additionalEmails.Text != "") { msg.CC.Add(additionalEmails.Text); };
            //if (countyEmail.Text != "") { msg.CC.Add(countyEmail.Text); }; //WILL UNCOMMENT LATER
            //if (ddcEmail.Text != "") { msg.CC.Add(ddcEmail.Text); }; //WILL UNCOMMENT LATER
            msg.Subject = subject;
            msg.From = new System.Net.Mail.MailAddress("support@soc.texas.gov");
            msg.Body = body;
            System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient();
            smtp.EnableSsl = true;
            smtp.UseDefaultCredentials = false;
            smtp.Credentials = new System.Net.NetworkCredential("postmaster@rs17820.mailgun.org", "3o8y30law8u2#1515");
            smtp.Host = "smtp.mailgun.org";
            smtp.Port = 587;
            smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
            if (Session["entryType"] != null && Session["entryType"] == "Live")
            {
                smtp.Send(msg);
            }
           

            Response.Redirect("Success.aspx");

        }

    }
}