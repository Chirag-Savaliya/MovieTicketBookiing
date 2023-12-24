<%@ Page Title="" Language="C#" MasterPageFile="~/MovieTickeBooking.master" AutoEventWireup="true" CodeFile="MovieMngmnt.aspx.cs" Inherits="MovieMngmnt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type="text/javascript">
        function MovieValidation()
        {
            var Rslt = false;
            if (document.getElementById("txtMoviName").value.length < 1)
            {
                document.getElementById("lblError").innerHTML = "Movie Name Must Not Be Empty";
            }
            else if (document.getElementById("txtMvDays").value.length < 1) {
                document.getElementById("lblError").innerHTML = "Movie Days Must Not Be Empty";
            }
            else if (DigitValidation(document.getElementById("txtMoviName").value))
            {
                document.getElementById("lblError").innerHTML = "Enter Valid Movie Name";
            }
            else
            {
                Rslt = true;
            }
            return Rslt;
        }
    </script>
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
                <asp:Label ID="lblError" runat="server" CssClass="Lbl-Error" ClientIDMode="Static" />
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
                            <p class="Lbl-Msg"> Enter Movie Name</p>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="10%" align="center">
                <p style="font-weight:bold">:</p>
            </td>
            <td width="45%" align="left">
                <asp:TextBox ID="txtMoviName" runat="server" ClientIDMode="Static"></asp:TextBox>
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
                            <p class="Lbl-Msg">Enter Total Number Of Days</p>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="10%" align="center">
                <p style="font-weight:bold">:</p>
            </td>
            <td width="45%" align="left">
                <asp:TextBox ID="txtMvDays" runat="server" ClientIDMode="Static" OnTextChanged="txtMvDays_TextChanged" AutoPostBack="true"></asp:TextBox>
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
                            <p class="Lbl-Msg"> Select Start Date For Movie</p>
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
                            <asp:TextBox ID="txtStrtDt" runat="server" ReadOnly="true"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Button ID="btnClndrMvStrtDt" runat="server" Text="..." CssClass="Btn" OnClick="btnClndrMvStrtDt_Click" />
                        </td>
                        <td>
                            <asp:Calendar ID="clndr" runat="server" BackColor="White" BorderColor="Black" BorderStyle="Solid" CellSpacing="1" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="100px" NextPrevFormat="ShortMonth" Width="50%" Visible="false" OnSelectionChanged="clndr_SelectionChanged">
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
            <td width="45%" align="center">
                <table>
                    <tr>
                        <td>
                            <p style="color:red">*</p>
                        </td>
                        <td>
                            <p class="Lbl-Msg">End Date For Movie</p>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="10%" align="center">
                <p style="font-weight:bold">:</p>
            </td>
            <td width="45%" align="left">
                <asp:TextBox ID="txtEndDt" runat="server" ReadOnly="true"></asp:TextBox>
            </td>
        </tr>

        <tr width="100%">
            <td width="45%" align="center">
                <table>
                    <tr>
                        <td>
                            <p style="color:red">*</p>
                        </td>
                        <td>
                            <p class="Lbl-Msg"> Select Image Of Movie</p>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="10%" align="center">
                <p style="font-weight:bold">:</p>
            </td>
            <td width="45%" align="left">
                <asp:FileUpload ID="flUpldMvBnr" runat="server" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <asp:Button ID="btnAddMv" runat="server" Text="ADD" Width="10%" CssClass="Btn" OnClientClick="return MovieValidation()" OnClick="btnAddMv_Click" />
            </td>
            <td align="center">
                <asp:Button ID="btnCnclMv" runat="server" Text="CANCEL" Width="11%" CssClass="Btn" OnClick="btnCnclMv_Click" />
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <asp:RadioButton ID="rdbtnCrnMv" runat="server" Text="Current Movie" Font-Bold="true" GroupName="Mv" OnCheckedChanged="Select_Movies" AutoPostBack="true" Checked="true" />
            </td>
            <td align="center">
                <asp:RadioButton ID="rdbtnAlMv" runat="server" Text="Pennding Movies" Font-Bold="true" GroupName="Mv" OnCheckedChanged="Select_Movies" AutoPostBack="true" />
            </td>
        </tr>
        <tr>
            <td colspan="3">
                  <asp:GridView ID="dtGrdMv" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" Width="100%" Visible="False">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="mvId" HeaderText="Movie Id" ReadOnly="True">
                        <ControlStyle Width="5%" />
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mvName" HeaderText="Movie Name">
                        <ControlStyle Width="20%" />
                        <ItemStyle Width="20%" HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mvStrtDt" HeaderText="Start Date">
                        <ControlStyle Width="20%" />
                        <ItemStyle Width="20%" HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mvEndDt" HeaderText="End Date">
                        <ControlStyle Width="20%" />
                        <ItemStyle Width="20%" HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:BoundField>
                        <asp:ImageField DataImageUrlField="mvId" DataImageUrlFormatString="HndlrMovie.ashx?mvPostr={0}" HeaderText="Poster">
                            <ControlStyle Width="25%" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="25%" />
                        </asp:ImageField>
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
                </td>
        </tr>
    </table>
</asp:Content>

