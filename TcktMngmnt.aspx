<%@ Page Title="" Language="C#" MasterPageFile="~/MovieTickeBooking.master" AutoEventWireup="true" CodeFile="TcktMngmnt.aspx.cs" Inherits="TcktMngmnt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type="text/javascript">
        function ValidateTcktRt()
        {
            var Rslt = false;
            if (document.getElementById("txtPltnmRtSetTcktRtView").value.length < 1)
            {
                document.getElementById("lblErrorSetTcktRtView").innerHTML = "Platinum Ticket Rate Must Not Be Empty.";
            }
            else if (document.getElementById("txtGldnRtSetTcktRtView").value.length < 1)
            {
                document.getElementById("lblErrorSetTcktRtView").innerHTML = "Golden Ticket Rate Must Not Be Empty.";
            }
            else if (document.getElementById("txtSlvrRtSetTcktRtView").value.length < 1)
            {
                document.getElementById("lblErrorSetTcktRtView").innerHTML = "Silver Ticket Rate Must Not Be Empty.";
            }
            else if (!DigitValidation(document.getElementById("txtPltnmRtSetTcktRtView").value))
            {
                document.getElementById("lblErrorSetTcktRtView").innerHTML = "Enter Valid Value Of Platinum Ticket Rate.";
            }
            else if (!DigitValidation(document.getElementById("txtGldnRtSetTcktRtView").value))
            {
                document.getElementById("lblErrorSetTcktRtView").innerHTML = "Enter Valid Value Of Golden Ticket Rate.";
            }
            else if (!DigitValidation(document.getElementById("txtSlvrRtSetTcktRtView").value))
            {
                document.getElementById("lblErrorSetTcktRtView").innerHTML = "Enter Valid Value Of Silver Ticket Rate.";
            }
            else if (parseInt(document.getElementById("txtPltnmRtSetTcktRtView").value) <= 0 || parseInt(document.getElementById("txtPltnmRtSetTcktRtView").value) > 200)
            {
                document.getElementById("lblErrorSetTcktRtView").innerHTML = "Platinum Rate Must Be Greater Than 0 And Less Than Or Equal To 200";
            }
            else if (parseInt(document.getElementById("txtGldnRtSetTcktRtView").value) <= 0 || parseInt(document.getElementById("txtGldnRtSetTcktRtView").value) > 150)
            {
                document.getElementById("lblErrorSetTcktRtView").innerHTML = "Golden Rate Must Be Greater Than 0 And Less Than Or Equal To 150";
            }
            else if (parseInt(document.getElementById("txtSlvrRtSetTcktRtView").value) <= 0 || parseInt(document.getElementById("txtSlvrRtSetTcktRtView").value) > 100)
            {
                document.getElementById("lblErrorSetTcktRtView").innerHTML = "Silver Rate Must Be Greater Than 0 And Less Than Or Equal To 100";
            }
            else
            {
                Rslt = true;
            }
            return Rslt;
        }
        function ValidateEdtTcktRtView()
        {
            var Rslt = false;
            if (document.getElementById("txtPltnmRtEdtTcktRtView").value.length < 1) {
                document.getElementById("lblErrorEdtTcktRtView").innerHTML = "Platinum Ticket Rate Must Not Be Empty.";
            }
            else if (document.getElementById("txtGldnRtEdtTcktRtView").value.length < 1) {
                document.getElementById("lblErrorEdtTcktRtView").innerHTML = "Golden Ticket Rate Must Not Be Empty.";
            }
            else if (document.getElementById("txtSlvrRtEdtcktRtView").value.length < 1) {
                document.getElementById("lblErrorEdtTcktRtView").innerHTML = "Silver Ticket Rate Must Not Be Empty.";
            }
            else if (!DigitValidation(document.getElementById("txtPltnmRtEdtTcktRtView").value)) {
                document.getElementById("lblErrorEdtTcktRtView").innerHTML = "Enter Valid Value Of Platinum Ticket Rate.";
            }
            else if (!DigitValidation(document.getElementById("txtGldnRtEdtTcktRtView").value)) {
                document.getElementById("lblErrorEdtTcktRtView").innerHTML = "Enter Valid Value Of Golden Ticket Rate.";
            }
            else if (!DigitValidation(document.getElementById("txtSlvrRtEdtcktRtView").value)) {
                document.getElementById("lblErrorEdtTcktRtView").innerHTML = "Enter Valid Value Of Silver Ticket Rate.";
            }
            else if (parseInt(document.getElementById("txtPltnmRtEdtTcktRtView").value) <= 0 || parseInt(document.getElementById("txtPltnmRtEdtTcktRtView").value) > 200) {
                document.getElementById("lblErrorEdtTcktRtView").innerHTML = "Platinum Rate Must Be Greater Than 0 And Less Than Or Equal To 200";
            }
            else if (parseInt(document.getElementById("txtGldnRtEdtTcktRtView").value) <= 0 || parseInt(document.getElementById("txtGldnRtEdtTcktRtView").value) > 150) {
                document.getElementById("lblErrorEdtTcktRtView").innerHTML = "Golden Rate Must Be Greater Than 0 And Less Than Or Equal To 150";
            }
            else if (parseInt(document.getElementById("txtSlvrRtEdtcktRtView").value) <= 0 || parseInt(document.getElementById("txtSlvrRtEdtcktRtView").value) > 100) {
                document.getElementById("lblErrorEdtTcktRtView").innerHTML = "Silver Rate Must Be Greater Than 0 And Less Than Or Equal To 100";
            }
            else {
                Rslt = true;
            }
            return Rslt;
        }
    </script>
    <asp:MultiView ID="mltVieTcktRt" runat="server" ActiveViewIndex="2">
       <asp:View ID="viewSetTcktRt" runat="server">
        <table border="0" class="Tbl-Outer">
          <tr>
            <td align="center" colspan="3">
             <asp:Image ID="imgMvBnrSetTcktRtView" runat="server" ImageUrl="~/Lighthouse.jpg" Width="20%" Height="310"></asp:Image>
            </td>
         </tr>

        <tr>
            <td align="center" colspan="3">
             <asp:Label ID="lblMvNmSetTcktRtView" runat="server" Font-Bold="true" ForeColor="Green" Font-Italic="true"></asp:Label>
            </td>
         </tr>

        <tr width="100%">
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
                <asp:Label ID="lblErrorSetTcktRtView" runat="server" CssClass="Lbl-Error" ClientIDMode="Static" />
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
                            <p class="Lbl-Msg">Select Show</p>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="10%" align="center">
                <p style="font-weight:bold">:</p>
            </td>
            <td width="45%" align="left">
                <asp:DropDownList ID="ddlShoSetTcktRtView" runat="server">
                    <asp:ListItem Text="-- Select Show --"></asp:ListItem>
                </asp:DropDownList>
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
                            <p class="Lbl-Msg">Ticket Rate</p>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="10%" align="center">
                <p style="font-weight:bold">:</p>
            </td>
            <td width="45%" align="left">
                <table>
                    <tr style="font-weight:bold">
                        <td>
                            P
                        </td>
                        <td>
                            <asp:TextBox ID="txtPltnmRtSetTcktRtView" runat="server" Width="25%" ClientIDMode="Static"></asp:TextBox>
                        </td>
                        <td>
                           G
                        </td>
                        <td>
                            <asp:TextBox ID="txtGldnRtSetTcktRtView" runat="server" Width="25%" ClientIDMode="Static"></asp:TextBox>
                        </td>
                        <td>
                           S
                        </td>
                        <td>
                            <asp:TextBox ID="txtSlvrRtSetTcktRtView" runat="server" Width="25%" ClientIDMode="Static"></asp:TextBox>
                        </td>
                    </tr>
                </table>
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
                            <p class="Lbl-Msg">Date</p>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="10%" align="center">
                <p style="font-weight:bold">:</p>
            </td>
            <td width="45%" align="left">
                <table>
                    <tr>
                        <td>
                            <asp:TextBox ID="dtSetTcktRtView" runat="server" ReadOnly="true"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Button ID="btnClndrSetTcktRtView" runat="server" Text="..." CssClass="Btn" OnClick="btnClndrSetTcktRtView_Click" />
                        </td>
                        <td>
                            <asp:Calendar ID="clndrSetTcktRtView" runat="server" BackColor="White" BorderColor="Black" BorderStyle="Solid" CellSpacing="1" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="100px" NextPrevFormat="ShortMonth" Width="50%" Visible="false" OnSelectionChanged="clndrSetTcktRtView_SelectionChanged">
                                <DayHeaderStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" Height="8pt" />
                                <DayStyle BackColor="#CCCCCC" />
                                <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="White" />
                                <OtherMonthDayStyle ForeColor="#999999" />
                                <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                                <TitleStyle BackColor="#333399" BorderStyle="Solid" Font-Bold="True" Font-Size="12pt" ForeColor="White" Height="12pt" />
                                <TodayDayStyle BackColor="#999999" ForeColor="White" />
                            </asp:Calendar>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>

         <tr>
            <td align="center" width="40%">
                <asp:Button ID="btnSetRt" runat="server" Text="SET RATE" Width="20%" CssClass="Btn" OnClientClick="return ValidateTcktRt()" OnClick="btnSetRt_Click" />
            </td>
            <td align="center" width="20%">
                <asp:Button ID="btnCnclSetTcktRtView" runat="server" Text="CANCEL" Width="25%" OnClick="btnCnclSetTcktRtView_Click" CssClass="Btn" />
            </td>
            <td align="center" width="40%">
                <asp:Button ID="btnBckSetTcktRtViw" runat="server" Text="BACK" Width="11%" OnClick="btnBckSetTcktRtViw_Click" CssClass="Btn" />
            </td>
         </tr>

        </table>
      </asp:View>

      <asp:View ID="viewEdtTcktRt" runat="server">
        <table border="0" class="Tbl-Outer">
          <tr>
            <td align="center" colspan="3">
             <asp:Image ID="mvBnrEdtTcktRtView" runat="server" ImageUrl="~/Lighthouse.jpg" Width="20%" Height="310"></asp:Image>
            </td>
         </tr>

        <tr>
            <td align="center" colspan="3">
             <asp:Label ID="lblMvNmEdtTcktRtView" runat="server" Font-Bold="true" ForeColor="Green" Font-Italic="true"></asp:Label>
            </td>
         </tr>

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
                <asp:Label ID="lblErrorEdtTcktRtView" runat="server" CssClass="Lbl-Error" ClientIDMode="Static" />
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
                            <p class="Lbl-Msg">Select Show</p>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="10%" align="center">
                <p style="font-weight:bold">:</p>
            </td>
            <td width="45%" align="left">
                <asp:DropDownList ID="ddlShowEdtTcktRtView" runat="server" OnSelectedIndexChanged="ddlShowEdtTcktRtView_SelectedIndexChanged" AutoPostBack="true">
                    <asp:ListItem Text="-- Select Show --"></asp:ListItem>
                </asp:DropDownList>
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
                            <p class="Lbl-Msg">Ticket Rate</p>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="10%" align="center">
                <p style="font-weight:bold">:</p>
            </td>
            <td width="45%" align="left">
                <table>
                    <tr style="font-weight:bold">
                        <td>
                            P
                        </td>
                        <td>
                            <asp:TextBox ID="txtPltnmRtEdtTcktRtView" runat="server" Width="25%" ClientIDMode="Static"></asp:TextBox>
                        </td>
                        <td>
                           G
                        </td>
                        <td>
                            <asp:TextBox ID="txtGldnRtEdtTcktRtView" runat="server" Width="25%" ClientIDMode="Static"></asp:TextBox>
                        </td>
                        <td>
                           S
                        </td>
                        <td>
                            <asp:TextBox ID="txtSlvrRtEdtcktRtView" runat="server" Width="25%" ClientIDMode="Static"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>

         <tr>
            <td align="center" width="40%">
                <asp:Button ID="btnUpdtRt" runat="server" Text="UPDATE RATE" Width="20%" CssClass="Btn" OnClientClick="return ValidateEdtTcktRtView()" OnClick="btnUpdtRt_Click" />
            </td>
            <td align="center" width="20%">
                <asp:Button ID="btnCnclEdtTcktRtView" runat="server" Text="CANCEL" Width="25%" OnClick="btnCnclEdtTcktRtView_Click" CssClass="Btn" />
            </td>
            <td align="center" width="40%">
                <asp:Button ID="btnBckEdtTcktRtViw" runat="server" Text="BACK" Width="11%" OnClick="btnBckEdtTcktRtViw_Click" CssClass="Btn" />
            </td>
         </tr>

        </table>
      </asp:View>

    <asp:View ID="viewBtnsTcktRtContrl" runat="server">
         <table>
             <tr width="100%">
                 <td width="50%" align="center">
                     <asp:Button ID="btnSetTcktRtView" runat="server" Text="SET RATE" Width="100%" OnClick="btnSetTcktRtView_Click" CssClass="Btn" />
                 </td>
                 <td widhth="50%" align="center">
                     <asp:Button ID="btnEdtTcktRtView" runat="server" Text="UPDATE RATE" Width="100%" OnClick="btnEdtTcktRtViw_Click" CssClass="Btn" />
                 </td>
             </tr>
         </table>
     </asp:View>
   </asp:MultiView>
    <asp:GridView ID="dtGrdTcktInfo" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" Width="100%" Visible="False">
                <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="shoName" HeaderText="Show Name">
                        <ControlStyle Width="20%" />
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="tcktDt" HeaderText="Date">
                        <ControlStyle Width="20%" />
                        <ItemStyle Width="20%" HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:BoundField>
                        <asp:BoundField DataField="tcktRtPltinum" HeaderText="Platinum Rate">
                        <ControlStyle Width="20%" />
                        <ItemStyle Width="20%" HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:BoundField>
                        <asp:BoundField DataField="tcktRtGoldn" HeaderText="Golden Rate">
                        <ControlStyle Width="20%" />
                        <ItemStyle Width="20%" HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:BoundField>
                        <asp:BoundField DataField="tcktRtSlver" HeaderText="Silver Rate">
                        <ControlStyle Width="20%" />
                        <ItemStyle Width="20%" HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:BoundField>
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

