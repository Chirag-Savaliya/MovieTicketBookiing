<%@ Page Title="" Language="C#" MasterPageFile="~/MovieTickeBooking.master" AutoEventWireup="true" CodeFile="Signin.aspx.cs" Inherits="Signin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type="text/javascript">
        function ValidationFrgtPassView()
        {
            var Rslt = false;
            if (document.getElementById("txtUserFrgtPassView").value.length < 1)
            {
                document.getElementById("lblErrorFrgtPassView").innerHTML = "User Name Must Not Be Empty.";
            }
            else if (!EmailValidation(document.getElementById("txtUserFrgtPassView").value)) {
                document.getElementById("lblErrorFrgtPassView").innerHTML = "Enter Valid User Name.";
            }
            else
            {
                document.getElementById("lblErrorFrgtPassView").innerHTML = "";
                Rslt = true;
            }
            return Rslt;
        }
        
        function ValidationPassRecViewView()
        {
            var Rslt = false;
            if (document.getElementById("txtQstnAnsrPassRec").value.length < 1)
            {
                document.getElementById("lblErrorPassRecView").innerHTML = "Question Answer Must Not Be Empty.";
            }
            else
            {
                document.getElementById("lblErrorPassRecView").innerHTML = "";
                Rslt = true;
            }
            return Rslt;
        }
        function ValidationLoginView()
        {
            var Rslt = false;
            if (document.getElementById("txtUsrnm").value.length < 1)
            {
                document.getElementById("lblError").innerHTML = "User Name Must Not Be Empty.";
            }
            else if (document.getElementById("txtPass").value.length < 1)
            {
                document.getElementById("lblError").innerHTML = "Password Must Not Be Empty.";
            }
            else if (!EmailValidation(document.getElementById("txtUsrnm").value))
            {
                document.getElementById("lblError").innerHTML = "Enter Valid User Name.";
            }
            else
            {
                Rslt = true;
                document.getElementById("lblError").innerHTML = "";
            }
            return Rslt;
        }
    </script>
<center>
    <div style="border:solid;border-color:purple;border-width:3px;width:50%;font-family:'Times New Roman';font-weight:bold">
     
      <asp:MultiView ID="mltViewLogin" runat="server" ActiveViewIndex="0">
          <asp:View ID="viewLogin" runat="server" OnActivate="viewLogin_Activate">
            <table border="0" class="Tbl-Outer">
        <tr>
            <td colspan="2" align="center">
                <p class="Lbl-Inst">Note : Your Registered Email Address Is Your User Name.</p>
            </td>
        </tr>
         <tr>
            <td colspan="2" align="center">
                <asp:Label ID="lblError" ClientIDMode="Static" runat="server" CssClass="Lbl-Error" />
            </td>
        </tr>
         <tr>
            <td width="50%" align="right">
             <p class="Lbl-Msg">Enter User Name</p>
            </td>
            <td width="50%" align="left">
                <asp:TextBox ID="txtUsrnm" runat="server" ClientIDMode="Static" />
            </td>
        </tr>
         <tr>
            <td width="50%" align="right">
             <p class="Lbl-Msg">Enter Password</p>
            </td>
            <td width="50%" align="left">
                <asp:TextBox ID="txtPass" runat="server" ClientIDMode="Static" TextMode="Password" />
            </td>
        </tr>
         <tr>
             <td colspan="2" align="center">
                 <asp:Button ID="btnLogin" runat="server" Text="SIGNIN" Width="12%" OnClientClick="return ValidationLoginView()" OnClick="btnLogin_Click" CssClass="Btn" />
             </td>
         </tr>
         <tr>
             <td colspan="2" align="center">
                 <asp:LinkButton ID="frgtPass" runat="server" Text="ForgetPassword" OnClientClick="" OnClick="frgtPass_Click"></asp:LinkButton>
             </td>
         </tr>
       </table>
     </asp:View>
      <asp:View ID="viewFrgtPass" runat="server" OnActivate="viewFrgtPass_Activate">
       <table border="0" class="Tbl-Outer">
            <tr>
            <td colspan="2" align="center">
                <asp:Label ID="lblErrorFrgtPassView" ClientIDMode="Static" runat="server" CssClass="Lbl-Error"/>
            </td>
           </tr>        
           <tr>
            <td width="50%" align="right">
             <p class="Lbl-Msg">Enter User Name</p>
            </td>
            <td width="50%" align="left">
                <asp:TextBox ID="txtUserFrgtPassView" runat="server" ClientIDMode="Static" />
            </td>
             </tr>
            <tr>
             <td colspan="2" align="center">
                 <asp:Button ID="btnNxt" runat="server" Text="NEXT" Width="12%" Font-Bold="true" OnClientClick="return ValidationFrgtPassView()" OnClick="btnNxt_Click" CssClass="Btn" />
             </td>
         </tr>
           <tr>
             <td colspan="2" align="center">
                 <asp:Button ID="btnCnclFrgtPassView" runat="server" Text="CANCEL" Width="12%" OnClientClick="" OnClick="btnCnclFrgtPassView_Click" CssClass="Btn" />
             </td>
         </tr>
    </table>
  </asp:View>
     <asp:View ID="viewPassRec" runat="server" OnActivate="viewPassRec_Activate">
       <table border="0" class="Tbl-Outer">
            <tr>
            <td colspan="2" align="center">
                <asp:Label ID="lblErrorPassRecView" ClientIDMode="Static" runat="server" CssClass="Lbl-Error" />
            </td>
           </tr> 
           <tr>
            <td width="50%" align="right">
             <p class="Lbl-Msg">Your Security Question</p>
            </td>
            <td width="50%" align="left">
                <asp:TextBox ID="txtUsrSecQstnPassRec" runat="server" ClientIDMode="Static" ReadOnly="true" />
            </td>
             </tr>
           <tr>
            <td width="50%" align="right">
             <p class="Lbl-Msg">Enter Question Answer</p>
            </td>
            <td width="50%" align="left">
                <asp:TextBox ID="txtQstnAnsrPassRec" runat="server" ClientIDMode="Static" />
            </td>
           </tr>
            <tr>
             <td colspan="2" align="center">
                 <asp:Button ID="btnNextFnl" runat="server" Text="NEXT" Width="12%" OnClientClick="return ValidationPassRecViewView()" OnClick="btnNextFnl_Click" CssClass="Btn" />
             </td>
         </tr>
         <tr>
             <td colspan="2" align="center">
                 <asp:Button ID="btnCnclRecPassView" runat="server" Text="CANCEL" Width="12%" OnClientClick="" OnClick="btnCnclRecPassView_Click" CssClass="Btn" />
             </td>
         </tr>
    </table>
  </asp:View>
 </asp:MultiView>  
</div>
</center>
</asp:Content>
