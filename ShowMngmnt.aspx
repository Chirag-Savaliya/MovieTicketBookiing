<%@ Page Title="" Language="C#" MasterPageFile="~/MovieTickeBooking.master" AutoEventWireup="true" CodeFile="ShowMngmnt.aspx.cs" Inherits="ShowMngmnt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type="text/javascript">
        function ShowValidation()
        {
            var Rslt = false;
            if (document.getElementById("txtShoName").value.length < 1)
            {
                document.getElementById("lblErrorAddShowView").innerHTML = "Show Name Must Not Be Empty.";
            }
            else if (!TextValidation(document.getElementById("txtShoName").value))
            {
                document.getElementById("lblErrorAddShowView").innerHTML = "Enter Valid Show Name.";
            }
            else
            {
                Rslt = true;
            }
            return Rslt;
        }
    </script>
    <asp:MultiView ID="mltVieShows" runat="server" ActiveViewIndex="1">
       <asp:View ID="viewAddShow" runat="server">
         <table border="0" class="Tbl-Outer">
            <tr>
              <td colspan="3" align="center">
                <table>
                    <tr>
                        <td class="Lbl-Inst">
                             Note : All Fields With
                        </td>
                        <td>
                             <p style="color:red">*</p>
                        </td>
                        <td class="Lbl-Inst">
                            Are Required.
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
          <tr>
            <td colspan="3" align="center">
                <asp:Label ID="lblErrorAddShowView" runat="server" CssClass="Lbl-Error" ClientIDMode="Static" />
            </td>
        </tr>

        <tr>
            <td width="45%" align="center">
                <table>
                    <tr>
                        <td>
                            <p style="color:red">*</p>
                        </td>
                        <td>
                            <p class="Lbl-Msg">Enter Show Name</p>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="10%" align="center">
                <p style="font-weight:bold">:</p>
            </td>
            <td width="45%" align="left">
                <asp:TextBox ID="txtShoName" runat="server" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td width="45%" align="center">
                <table>
                    <tr>
                        <td>
                            <p style="color:red">*</p>
                        </td>
                        <td>
                            <p class="Lbl-Msg">Select Show Time</p>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="10%" align="center">
                <p style="font-weight:bold">:</p>
            </td>
            <td width="45%" align="left">
                <asp:DropDownList ID="ddlShoTime" runat="server">
                    <asp:ListItem Text="-- Select Show Time --"></asp:ListItem>
                </asp:DropDownList>
            </td>
         </tr>
          <tr>
            <td align="center" width="40%">
                <asp:Button ID="btnAddMv" runat="server" Text="ADD" Width="10%" CssClass="Btn" OnClientClick="return ShowValidation()" OnClick="btnAddMv_Click" />
            </td>
            <td align="center" width="20%">
                <asp:Button ID="btnCnclAddShoView" runat="server" Text="CANCEL" Width="25%" CssClass="Btn" />
            </td>
            <td align="center" width="40%">
                <asp:Button ID="btnBckAdShoViw" runat="server" Text="BACK" Width="11%" OnClick="btnBckAdShoViw_Click" CssClass="Btn" />
            </td>
          </tr>
       </table>
      </asp:View>

     <asp:View ID="viewBtnsShoContrl" runat="server">
         <table>
             <tr>
                 <td width="50%" align="center">
                     <asp:Button ID="btnAddShoViw" runat="server" Text="ADD NEW SHOW" Width="100%" OnClick="btnAddShoViw_Click" CssClass="Btn" />
                 </td>
             </tr>
         </table>
     </asp:View>
   </asp:MultiView>
    <table width="100%">
        <tr>
                 <td style="font-weight:bold" width="50%" align="center">
                     Select Shows
                 </td>
                 <td width="50%" align="center">
                     <asp:DropDownList ID="ddlSlctShows" runat="server" OnSelectedIndexChanged="ddlSlctShows_SelectedIndexChanged" AutoPostBack="true">
                         <asp:ListItem Text="-- Currently Running Shows --" Selected="True"></asp:ListItem>
                         <asp:ListItem Text="-- Past Shows --"></asp:ListItem>
                     </asp:DropDownList>
                 </td>
          </tr>
    </table>
    <asp:GridView ID="dtGrdSho" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" Width="100%" Visible="False" OnRowDeleting="dtGrdSho_RowDeleting">
                <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="shoId" HeaderText="Show Id" ReadOnly="True">
                        <ControlStyle Width="10%" />
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="shoName" HeaderText="Show Name">
                        <ControlStyle Width="20%" />
                        <ItemStyle Width="20%" HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:BoundField>
                        <asp:BoundField DataField="shoStrtTime" HeaderText="Show Start Time">
                        <ControlStyle Width="20%" />
                        <ItemStyle Width="20%" HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:BoundField>
                        <asp:BoundField DataField="shoDt" HeaderText="Date">
                        <ControlStyle Width="25%" />
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="25%" />
                        </asp:BoundField>
                        <asp:CommandField ButtonType="Button" HeaderText="Delete Show" ShowDeleteButton="True">
                        <ControlStyle Width="25%" />
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="25%" />
                        </asp:CommandField>
                    </Columns>
                    <EditRowStyle BackColor="#7C6F57" />
                    <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" VerticalAlign="Middle" />
                    <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#E3EAEB" />
                    <SelectedRowStyle BackColor="#CC3300" Font-Bold="True" ForeColor="#FFFF99" />
                    <SortedAscendingCellStyle BackColor="#F8FAFA" />
                    <SortedAscendingHeaderStyle BackColor="#246B61" />
                    <SortedDescendingCellStyle BackColor="#D4DFE1" />
                    <SortedDescendingHeaderStyle BackColor="#15524A" />
    </asp:GridView>
</asp:Content>

