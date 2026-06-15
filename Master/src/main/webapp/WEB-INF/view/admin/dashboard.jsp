<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Admin Banner -->
<section style="background: linear-gradient(135deg, #1c1c2e 0%, #2d2d44 100%);
                border-bottom: 4px solid #ffbe30; padding: 28px 0;">
    <div class="container">
        <div style="display:flex; align-items:center; justify-content:space-between; flex-wrap:wrap; gap:12px;">
            <div>
                <div style="color:#ffbe30; font-size:12px; font-weight:700; letter-spacing:2px;
                            text-transform:uppercase; margin-bottom:6px;">
                    <i class="fas fa-crown" style="margin-right:6px;"></i>Administration Panel
                </div>
                <h2 style="color:#fff; font-size:26px; font-weight:800; margin:0;">Dashboard Overview</h2>
            </div>
            <div style="display:flex; gap:8px;">
                <a href="${pageContext.request.contextPath}/admin/dashboard"
                   style="background:${active=='dashboard'?'#ffbe30':'rgba(255,190,48,.15)'}; color:${active=='dashboard'?'#1c1c2e':'#ffbe30'};
                          border:1px solid #ffbe30; border-radius:20px; padding:7px 18px;
                          font-size:13px; font-weight:600; text-decoration:none;">
                    <i class="fas fa-gauge-high" style="margin-right:5px;"></i>Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/admin/users"
                   style="background:${active=='users'?'#ffbe30':'rgba(255,190,48,.15)'}; color:${active=='users'?'#1c1c2e':'#ffbe30'};
                          border:1px solid #ffbe30; border-radius:20px; padding:7px 18px;
                          font-size:13px; font-weight:600; text-decoration:none;">
                    <i class="fas fa-users" style="margin-right:5px;"></i>Users
                </a>
                <a href="${pageContext.request.contextPath}/admin/events"
                   style="background:${active=='events'?'#ffbe30':'rgba(255,190,48,.15)'}; color:${active=='events'?'#1c1c2e':'#ffbe30'};
                          border:1px solid #ffbe30; border-radius:20px; padding:7px 18px;
                          font-size:13px; font-weight:600; text-decoration:none;">
                    <i class="fas fa-calendar-alt" style="margin-right:5px;"></i>Events
                </a>
            </div>
        </div>
    </div>
</section>

<script>
function filterRows(tbodyId, query) {
    var rows = document.getElementById(tbodyId).getElementsByTagName('tr');
    query = query.toLowerCase();
    for (var i = 0; i < rows.length; i++) {
        rows[i].style.display = rows[i].textContent.toLowerCase().includes(query) ? '' : 'none';
    }
}
</script>

<!-- Admin Content -->
<section style="background:#f8f9fa; padding: 40px 0; min-height:60vh;">
    <div class="container">

        <c:if test="${not empty successMessage}">
            <div style="background:#d4edda; border:1px solid #c3e6cb; color:#155724;
                        border-radius:8px; padding:12px 18px; margin-bottom:20px; font-size:14px;">
                <i class="fas fa-check-circle" style="margin-right:8px;"></i>${successMessage}
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div style="background:#f8d7da; border:1px solid #f5c6cb; color:#721c24;
                        border-radius:8px; padding:12px 18px; margin-bottom:20px; font-size:14px;">
                <i class="fas fa-exclamation-circle" style="margin-right:8px;"></i>${errorMessage}
            </div>
        </c:if>

        <!-- Stat Cards -->
        <div style="display:grid; grid-template-columns:repeat(auto-fill,minmax(160px,1fr)); gap:16px; margin-bottom:36px;">
            <div style="background:#fff; border-radius:12px; padding:20px; border:1px solid #e9ecef;
                        box-shadow:0 2px 8px rgba(0,0,0,.06); display:flex; align-items:center; gap:14px;">
                <div style="width:48px; height:48px; border-radius:12px; background:rgba(255,190,48,.15);
                            color:#e07820; display:flex; align-items:center; justify-content:center; font-size:20px; flex-shrink:0;">
                    <i class="fas fa-user-tie"></i>
                </div>
                <div>
                    <div style="font-size:26px; font-weight:800; color:#1c1c2e; line-height:1;">${totalCompanies}</div>
                    <div style="font-size:11px; color:#888; text-transform:uppercase; letter-spacing:.8px; margin-top:4px;">Companies</div>
                </div>
            </div>
            <div style="background:#fff; border-radius:12px; padding:20px; border:1px solid #e9ecef;
                        box-shadow:0 2px 8px rgba(0,0,0,.06); display:flex; align-items:center; gap:14px;">
                <div style="width:48px; height:48px; border-radius:12px; background:rgba(255,190,48,.15);
                            color:#e07820; display:flex; align-items:center; justify-content:center; font-size:20px; flex-shrink:0;">
                    <i class="fas fa-hard-hat"></i>
                </div>
                <div>
                    <div style="font-size:26px; font-weight:800; color:#1c1c2e; line-height:1;">${totalWorkhands}</div>
                    <div style="font-size:11px; color:#888; text-transform:uppercase; letter-spacing:.8px; margin-top:4px;">Workhands</div>
                </div>
            </div>
            <div style="background:#fff; border-radius:12px; padding:20px; border:1px solid #e9ecef;
                        box-shadow:0 2px 8px rgba(0,0,0,.06); display:flex; align-items:center; gap:14px;">
                <div style="width:48px; height:48px; border-radius:12px; background:rgba(255,190,48,.15);
                            color:#e07820; display:flex; align-items:center; justify-content:center; font-size:20px; flex-shrink:0;">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <div>
                    <div style="font-size:26px; font-weight:800; color:#1c1c2e; line-height:1;">${totalEvents}</div>
                    <div style="font-size:11px; color:#888; text-transform:uppercase; letter-spacing:.8px; margin-top:4px;">Events</div>
                </div>
            </div>
            <div style="background:#fff; border-radius:12px; padding:20px; border:1px solid #e9ecef;
                        box-shadow:0 2px 8px rgba(0,0,0,.06); display:flex; align-items:center; gap:14px;">
                <div style="width:48px; height:48px; border-radius:12px; background:rgba(255,190,48,.15);
                            color:#e07820; display:flex; align-items:center; justify-content:center; font-size:20px; flex-shrink:0;">
                    <i class="fas fa-clipboard-list"></i>
                </div>
                <div>
                    <div style="font-size:26px; font-weight:800; color:#1c1c2e; line-height:1;">${totalRegs}</div>
                    <div style="font-size:11px; color:#888; text-transform:uppercase; letter-spacing:.8px; margin-top:4px;">Applications</div>
                </div>
            </div>
            <div style="background:#fff; border-radius:12px; padding:20px; border:1px solid #e9ecef;
                        box-shadow:0 2px 8px rgba(0,0,0,.06); display:flex; align-items:center; gap:14px;">
                <div style="width:48px; height:48px; border-radius:12px; background:rgba(255,190,48,.15);
                            color:#e07820; display:flex; align-items:center; justify-content:center; font-size:20px; flex-shrink:0;">
                    <i class="fas fa-user-check"></i>
                </div>
                <div>
                    <div style="font-size:26px; font-weight:800; color:#1c1c2e; line-height:1;">${approvedRegs}</div>
                    <div style="font-size:11px; color:#888; text-transform:uppercase; letter-spacing:.8px; margin-top:4px;">Approved</div>
                </div>
            </div>
            <div style="background:#fff; border-radius:12px; padding:20px; border:1px solid #e9ecef;
                        box-shadow:0 2px 8px rgba(0,0,0,.06); display:flex; align-items:center; gap:14px;">
                <div style="width:48px; height:48px; border-radius:12px; background:rgba(255,190,48,.15);
                            color:#e07820; display:flex; align-items:center; justify-content:center; font-size:20px; flex-shrink:0;">
                    <i class="fas fa-credit-card"></i>
                </div>
                <div>
                    <div style="font-size:26px; font-weight:800; color:#1c1c2e; line-height:1;">${paidRegs}</div>
                    <div style="font-size:11px; color:#888; text-transform:uppercase; letter-spacing:.8px; margin-top:4px;">Paid</div>
                </div>
            </div>
        </div>

        <!-- Tables -->
        <div class="row">
            <!-- Recent Events -->
            <div class="col-lg-6 mb-4">
                <div style="background:#fff; border-radius:12px; border:1px solid #e9ecef;
                            box-shadow:0 2px 8px rgba(0,0,0,.06); overflow:hidden;">
                    <div style="padding:14px 20px; border-bottom:2px solid #ffbe30;
                                display:flex; justify-content:space-between; align-items:center; background:#fff;">
                        <span style="font-weight:700; color:#1c1c2e; font-size:15px;">
                            <i class="fas fa-calendar" style="color:#e07820; margin-right:8px;"></i>Recent Events
                        </span>
                        <div style="display:flex; align-items:center; gap:8px;">
                            <input type="text" id="evSearch" placeholder="Search events..."
                                   oninput="filterRows('evTbody', this.value)"
                                   style="border:1px solid #ced4da; border-radius:8px; padding:5px 10px;
                                          font-size:12px; outline:none; width:150px;">
                            <a href="${pageContext.request.contextPath}/admin/events"
                               style="background:#ffbe30; color:#1c1c2e; border-radius:20px; padding:6px 16px;
                                      font-size:12px; font-weight:700; text-decoration:none; white-space:nowrap;">View All</a>
                        </div>
                    </div>
                    <div style="overflow-x:auto;">
                        <table style="width:100%; border-collapse:collapse; font-size:13px;">
                            <thead>
                                <tr style="background:#ffbe30;">
                                    <th style="padding:10px 14px; color:#1c1c2e; font-size:11px; font-weight:700;
                                               text-transform:uppercase; letter-spacing:.6px; white-space:nowrap;">Event</th>
                                    <th style="padding:10px 14px; color:#1c1c2e; font-size:11px; font-weight:700;
                                               text-transform:uppercase; letter-spacing:.6px;">Company</th>
                                    <th style="padding:10px 14px; color:#1c1c2e; font-size:11px; font-weight:700;
                                               text-transform:uppercase; letter-spacing:.6px; text-align:center;">Featured</th>
                                    <th style="padding:10px 14px; color:#1c1c2e; font-size:11px; font-weight:700;
                                               text-transform:uppercase; letter-spacing:.6px; text-align:center;">Actions</th>
                                </tr>
                            </thead>
                            <tbody id="evTbody">
                                <c:forEach var="ev" items="${recentEvents}">
                                    <tr style="border-bottom:1px solid #f0f0f0;">
                                        <td style="padding:10px 14px; color:#333; font-weight:600;
                                                   max-width:140px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;"
                                            title="${ev.eventName}">${ev.eventName}</td>
                                        <td style="padding:10px 14px; color:#666; font-size:12px;">
                                            <c:if test="${ev.company != null}">${ev.company.name}</c:if>
                                        </td>
                                        <td style="padding:10px 14px; text-align:center;">
                                            <c:choose>
                                                <c:when test="${ev.featured}">
                                                    <span style="background:#fff3cd; color:#856404;
                                                                 border-radius:20px; padding:2px 10px; font-size:11px; font-weight:600;">
                                                        <i class="fas fa-star"></i> Yes
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="background:#f8f9fa; color:#999;
                                                                 border-radius:20px; padding:2px 10px; font-size:11px;">—</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="padding:10px 14px; text-align:center; white-space:nowrap;">
                                            <form action="${pageContext.request.contextPath}/admin/events/${ev.id}/toggle-featured"
                                                  method="POST" style="display:inline-block; margin-right:6px;">
                                                <input type="hidden" name="from" value="dashboard">
                                                <button type="submit"
                                                        style="background:#fff3cd; border:1px solid #ffc107; color:#856404;
                                                               border-radius:6px; padding:5px 10px; font-size:13px; cursor:pointer;
                                                               min-width:32px;"
                                                        title="Toggle Featured"><i class="fas fa-star"></i></button>
                                            </form>
                                            <form action="${pageContext.request.contextPath}/admin/events/${ev.id}/delete"
                                                  method="POST" style="display:inline-block;"
                                                  onsubmit="return confirm('Delete this event?')">
                                                <button type="submit"
                                                        style="background:#f8d7da; border:1px solid #f5c6cb; color:#721c24;
                                                               border-radius:6px; padding:5px 10px; font-size:13px; cursor:pointer;
                                                               min-width:32px;"
                                                        title="Delete"><i class="fas fa-trash"></i></button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty recentEvents}">
                                    <tr><td colspan="4" style="text-align:center; color:#aaa; padding:24px;">No events found.</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Recent Applications -->
            <div class="col-lg-6 mb-4">
                <div style="background:#fff; border-radius:12px; border:1px solid #e9ecef;
                            box-shadow:0 2px 8px rgba(0,0,0,.06); overflow:hidden;">
                    <div style="padding:14px 20px; border-bottom:2px solid #ffbe30;
                                display:flex; justify-content:space-between; align-items:center; background:#fff; flex-wrap:wrap; gap:8px;">
                        <span style="font-weight:700; color:#1c1c2e; font-size:15px;">
                            <i class="fas fa-clipboard-list" style="color:#e07820; margin-right:8px;"></i>Recent Applications
                        </span>
                        <div style="display:flex; align-items:center; gap:8px;">
                            <input type="text" id="regSearch" placeholder="Search by ID or status..."
                                   oninput="filterRows('regTbody', this.value)"
                                   style="border:1px solid #ced4da; border-radius:8px; padding:5px 10px;
                                          font-size:12px; outline:none; width:170px;">
                            <a href="${pageContext.request.contextPath}/admin/users"
                               style="background:#ffbe30; color:#1c1c2e; border-radius:20px; padding:6px 16px;
                                      font-size:12px; font-weight:700; text-decoration:none; white-space:nowrap;">Users</a>
                        </div>
                    </div>
                    <div style="overflow-x:auto;">
                        <table style="width:100%; border-collapse:collapse; font-size:13px;">
                            <thead>
                                <tr style="background:#ffbe30;">
                                    <th style="padding:10px 14px; color:#1c1c2e; font-size:11px; font-weight:700;
                                               text-transform:uppercase; letter-spacing:.6px;">#ID</th>
                                    <th style="padding:10px 14px; color:#1c1c2e; font-size:11px; font-weight:700;
                                               text-transform:uppercase; letter-spacing:.6px;">Status</th>
                                    <th style="padding:10px 14px; color:#1c1c2e; font-size:11px; font-weight:700;
                                               text-transform:uppercase; letter-spacing:.6px;">Payment</th>
                                    <th style="padding:10px 14px; color:#1c1c2e; font-size:11px; font-weight:700;
                                               text-transform:uppercase; letter-spacing:.6px;">Date</th>
                                </tr>
                            </thead>
                            <tbody id="regTbody">
                                <c:forEach var="reg" items="${recentRegs}">
                                    <tr style="border-bottom:1px solid #f0f0f0;">
                                        <td style="padding:10px 14px; color:#666;">#${reg.registrationId}</td>
                                        <td style="padding:10px 14px;">
                                            <c:choose>
                                                <c:when test="${reg.registrationStatus}">
                                                    <span style="background:#d4edda; color:#155724;
                                                                 border-radius:20px; padding:2px 10px; font-size:11px; font-weight:600;">Approved</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="background:#f8f9fa; color:#888;
                                                                 border-radius:20px; padding:2px 10px; font-size:11px;">Pending</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="padding:10px 14px;">
                                            <c:choose>
                                                <c:when test="${reg.paymentStatus}">
                                                    <span style="background:#fff3cd; color:#856404;
                                                                 border-radius:20px; padding:2px 10px; font-size:11px; font-weight:600;">Paid</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="background:#f8f9fa; color:#888;
                                                                 border-radius:20px; padding:2px 10px; font-size:11px;">Unpaid</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="padding:10px 14px; color:#666; font-size:12px;">${reg.registrationDate}</td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty recentRegs}">
                                    <tr><td colspan="4" style="text-align:center; color:#aaa; padding:24px;">No applications found.</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>
</section>
