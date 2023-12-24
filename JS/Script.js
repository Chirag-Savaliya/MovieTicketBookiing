function TextValidation(txt) {
    var x = 0;
    for (var a = 0; a < txt.length; a++) {
        if ((parseInt(txt.charCodeAt(a)) >= 65 && parseInt(txt.charCodeAt(a)) <= 90) || (parseInt(txt.charCodeAt(a)) >= 97 && parseInt(txt.charCodeAt(a)) <= 122)) {
            x++;
        }
    }
    if (txt.length == x) {
        return true;
    }
    else {
        return false;
    }
}
function DigitValidation(dgt)
{
    var x = 0;
    for (var a = 0; a < dgt.length; a++)
    {
        if ((parseInt(dgt.charCodeAt(a)) >= 48 && parseInt(dgt.charCodeAt(a)) <= 57))
        {
            x++;
        }
    }
    if (dgt.length == x)
    {
        return true;
    }
    else
    {
        return false;
    }
}
function AddressValidation(addrs) {
    var x = 0;
    for (var a = 0; a < addrs.length; a++) {
        if ((parseInt(addrs.charCodeAt(a)) >= 65 && parseInt(addrs.charCodeAt(a)) <= 90) || (parseInt(addrs.charCodeAt(a)) >= 97 && parseInt(addrs.charCodeAt(a)) <= 122)) {
            x++;
        }
        if ((parseInt(addrs.charCodeAt(a)) >= 48 && parseInt(addrs.charCodeAt(a)) <= 57)) {
            x++;
        }
        if (parseInt(addrs.charCodeAt(a)) >= 44 && parseInt(addrs.charCodeAt(a)) <= 47) {
            x++;
        }
        if (parseInt(addrs.charCodeAt(a)) == 32) {
            x++;
        }
        if (parseInt(addrs.charCodeAt(a)) == 40 || parseInt(addrs.charCodeAt(a)) == 41) {
            x++;
        }
        if (parseInt(addrs.charCodeAt(a)) == 58) {
            x++;
        }
    }

    if (addrs.length == x) {
        return true;
    }
    else {
        return false;
    }
}
function EmailValidation(EmlArg) {
    if (EmlArg.includes('@')) {
        var x = 0;
        var SpltEml = EmlArg.split('@');
        if (SpltEml.length == 2) {
            for (var a = 0; a < SpltEml[0].length; a++) {
                if ((parseInt(SpltEml[0].charCodeAt(a)) >= 65 && parseInt(SpltEml[0].charCodeAt(a)) <= 90) || (parseInt(SpltEml[0].charCodeAt(a)) >= 97 && parseInt(SpltEml[0].charCodeAt(a)) <= 122)) {
                    x++;
                }
                else if ((parseInt(SpltEml[0].charCodeAt(a)) >= 48 && parseInt(SpltEml[0].charCodeAt(a)) <= 57)) {
                    x++;
                }
            }
            if ((SpltEml[0].length == x && SpltEml[1] == "gmail.com") || (SpltEml[0].length == x && SpltEml[1] == "yahoo.com")) {
                return true;
            }
            else {
                return false;
            }
        }
        else {
            return false;
        }
    }
    else {
        return false;
    }
}
