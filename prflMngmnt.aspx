<%@ Page Title="" Language="C#" MasterPageFile="~/MovieTickeBooking.master" AutoEventWireup="true" CodeFile="prflMngmnt.aspx.cs" Inherits="prflMngmnt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type="text/javascript">
        function ProfileValidation()
        {
            var Rslt=false;
            if (document.getElementById("btnPrfl").value.toString() == "UPDATE PROFILE")
            {
                if (document.getElementById("txtFrstnm").value.length < 1)
                {
                    document.getElementById("lblError").innerHTML = "First Name Must Not Be Empty.";
                }
                else if (document.getElementById("txtLstnm").value.length < 1)
                {
                    document.getElementById("lblError").innerHTML = "Last Name Must Not Be Empty.";
                }
                else if (document.getElementById("txtMono").value.length < 1)
                {
                    document.getElementById("lblError").innerHTML = "Mono Must Not Be Empty.";
                }
                else if (document.getElementById("txtMono").value.length < 10)
                {
                    document.getElementById("lblError").innerHTML = "Enter Valid Phone No.";
                }
                else if (document.getElementById("txtAddrs").value.length < 1)
                {
                    document.getElementById("lblError").innerHTML = "Address Must Not Be Empty.";
                }
                else if (document.getElementById("txtPass").value.length < 1)
                {
                    document.getElementById("lblError").innerHTML = "Password Must Not Be Empty.";
                }
                else if (document.getElementById("txtCnfrmPass").value.length < 1)
                {
                    document.getElementById("lblError").innerHTML = "Confirm Password Must Not Be Empty.";
                }
                else if (document.getElementById("txtSecQstn").value.length < 1)
                {
                    document.getElementById("lblError").innerHTML = "Security Question Must Not Be Empty.";
                }

                else if (document.getElementById("txtQstnAnsr").value.length < 1)
                {
                    document.getElementById("lblError").innerHTML = "Question Answer Must Not Be Empty.";
                }
                else if (!TextValidation(document.getElementById("txtFrstnm").value))
                {
                    document.getElementById("lblError").innerHTML = "Enter Valid First Name.";
                }
                else if (!TextValidation(document.getElementById("txtLstnm").value))
                {
                    document.getElementById("lblError").innerHTML = "Enter Valid Last Name.";
                }
                else if (!DigitValidation(document.getElementById("txtMono").value))
                {
                    document.getElementById("lblError").innerHTML = "Enter Valid Phone No.";
                }
                else if (!AddressValidation(document.getElementById("txtAddrs").value))
                {
                    document.getElementById("lblError").innerHTML = "Enter Valid Address.";
                }
                else if (document.getElementById("txtPass").value != document.getElementById("txtCnfrmPass").value)
                {
                    document.getElementById("lblError").innerHTML = "Password Does Not Matchs.";
                }
                else
                {
                    document.getElementById("lblError").innerHTML = "";
                    Rslt = true;
                }
            }
            else
            {
                Rslt = true;
            }
            return Rslt;
        }

    </script>
    <center>
        <div style="width:100%;font-family:'Times New Roman';font-weight:bold;border:solid;border-width:2px">
            <asp:Panel ID="pnlPrfl" runat="server" Width="100%" ClientIDMode="Static" Visible="false">
             <table border="0" class="Tbl-Outer">
                <tr>
                    <td align="center" colspan="2">
                        <asp:Label ID="lblError" ClientIDMode="Static" runat="server" class="Lbl-Error" />
                    </td>
                </tr>
                <tr>
                    <td width="50%" align="right">
                      <p class="Lbl-Msg">First Name</p>
                   </td>
                  <td width="50%" align="left">
                   <asp:TextBox ID="txtFrstnm" runat="server" ClientIDMode="Static" />
                  </td>
                </tr>
                 <tr>
                    <td width="50%" align="right">
                      <p class="Lbl-Msg">Last Name</p>
                   </td>
                  <td width="50%" align="left">
                   <asp:TextBox ID="txtLstnm" runat="server" ClientIDMode="Static" />
                  </td>
                </tr>
                 <tr>
                    <td width="50%" align="right">
                      <p class="Lbl-Msg">Phone No</p>
                   </td>
                  <td width="50%" align="left">
                   <asp:TextBox ID="txtMono" runat="server" ClientIDMode="Static" MaxLength="10" />
                  </td>
                </tr>
                 <tr>
                    <td width="50%" align="right">
                      <p class="Lbl-Msg">Address</p>
                   </td>
                  <td width="50%" align="left">
                   <asp:TextBox ID="txtAddrs" runat="server" ClientIDMode="Static"  Width="80%" TextMode="MultiLine" style="resize:none" />
                  </td>
                </tr>
                <tr>
                    <td width="50%" align="right">
                      <p class="Lbl-Msg">Password</p>
                   </td>
                  <td width="50%" align="left">
                   <asp:TextBox ID="txtPass" runat="server" ClientIDMode="Static" />
                  </td>
                </tr>
                 <tr>
                    <td width="50%" align="right">
                      <p class="Lbl-Msg">Confirm Password</p>
                   </td>
                  <td width="50%" align="left">
                   <asp:TextBox ID="txtCnfrmPass" runat="server" ClientIDMode="Static" />
                  </td>
                </tr>
                <tr>
                   <td width="50%" align="right">
                      <p class="Lbl-Msg">Security Question</p>
                   </td>
                  <td width="50%" align="left">
                   <asp:TextBox ID="txtSecQstn" runat="server" ClientIDMode="Static" />
                  </td>
                </tr>
                <tr>
                   <td width="50%" align="right">
                      <p class="Lbl-Msg">Question Answer</p>
                   </td>
                  <td width="50%" align="left">
                   <asp:TextBox ID="txtQstnAnsr" runat="server" ClientIDMode="Static" />
                  </td>
                </tr>
                 <tr>
                    <td colspan="2" align="center">
                        <asp:Button ID="btnCncl" runat="server" ClientIDMode="Static" Text="CANCEL" Width="12%" OnClick="btnCncl_Click" CssClass="Btn" />
                    </td>
                </tr>
            </table>
          </asp:Panel>
            <table border="0" width="100%">
                <tr>
                    <td colspan="2" align="center">
                        <asp:Button ID="btnPrfl" runat="server" ClientIDMode="Static" Text="EDIT PROFILE" Width="12%" OnClientClick="return ProfileValidation()" OnClick="btnPrfl_Click" CssClass="Btn" />
                    </td>
                </tr>
            </table>
        </div>
    </center>
</asp:Content>

