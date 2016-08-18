function validateEmail(email) {
            var str = email.replace(/\s/g, '');
            var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            return re.test(str);
        }


//submitterEmail
function finalEmailCheck() {
            var checkEmail = function (a) {
                for (var i = 0; i &lt; a.length; i++) {
                    if (a[i] != '' &amp;&amp; validateEmail(a[i]) == false) {
                        return false;
                    }
                }
            };
            var e = document.getElementById('submitterEmail').value.split(/[ ,;]+/);
            if(checkEmail(e) != false){
                document.getElementById('submitterEmail').value=e.join(',');
            };
            var b = document.getElementById('additionalEmails').value.split(/[ ,;]+/);
            if(checkEmail(b) != false){
                document.getElementById('additionalEmails').value=b.join(',');
            };
            var c = document.getElementById('countyEmail').value.split(/[ ,;]+/);
            if(checkEmail(c) != false){
                document.getElementById('countyEmail').value=c.join(',');
            };
            var d = document.getElementById('ddcEmail').value.split(/[ ,;]+/);
            if(checkEmail(d) != false){
                document.getElementById('ddcEmail').value=d.join(',');
            };
            

        }

         function submit() {
            if(finalEmailCheck() == false){
                alert('Please check your email format');
                return false;
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