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
                <h2 style="color:#fff; font-size:26px; font-weight:800; margin:0;">User Management</h2>
                <p style="color:#aaa; font-size:13px; margin:6px 0 0;">${users.totalElements} total users</p>
            </div>
            <div style="display:flex; gap:8px; flex-wrap:wrap;">
                <a href="${pageContext.request.contextPath}/admin/dashboard"
                   style="background:rgba(255,190,48,.15); color:#ffbe30; border:1px solid #ffbe30;
                          border-radius:20px; padding:7px 18px; font-size:13px; font-weight:600; text-decoration:none;">
                    <i class="fas fa-gauge-high" style="margin-right:5px;"></i>Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/admin/users"
                   style="background:#ffbe30; color:#1c1c2e; border:1px solid #ffbe30;
                          border-radius:20px; padding:7px 18px; font-size:13px; font-weight:600; text-decoration:none;">
                    <i class="fas fa-users" style="margin-right:5px;"></i>Users
                </a>
                <a href="${pageContext.request.contextPath}/admin/events"
                   style="background:rgba(255,190,48,.15); color:#ffbe30; border:1px solid #ffbe30;
                          border-radius:20px; padding:7px 18px; font-size:13px; font-weight:600; text-decoration:none;">
                    <i class="fas fa-calendar-alt" style="margin-right:5px;"></i>Events
                </a>
            </div>
        </div>
    </div>
</section>

<!-- Content -->
<section style="background:#f8f9fa; padding:40px 0; min-height:60vh;">
    <div class="container">

        <c:if test="${not empty successMessage}">
            <div style="background:#d4edda; border:1px solid #c3e6cb; color:#155724;
                        border-radius:8px; padding:12px 18px; margin-bottom:20px; font-size:14px;">
                <i class="fas fa-check-circle" style="margin-right:8px;"></i>${successMessage}
            </div>
        </c:if>

        <!-- Filter Bar -->
        <form method="GET" action="${pageContext.request.contextPath}/admin/users">
            <div style="background:#fff; border-radius:10px; padding:14px 20px; margin-bottom:20px;
                        border:1px solid #e9ecef; box-shadow:0 1px 4px rgba(0,0,0,.05);
                        display:flex; align-items:center; gap:12px; flex-wrap:wrap;">
                <select name="role"
                        style="background:#fff; border:1px solid #ced4da; color:#333;
                               border-radius:8px; padding:8px 12px; font-size:13px; outline:none;">
                    <option value="ALL"      ${selectedRole == 'ALL'      ? 'selected' : ''}>All Roles</option>
                    <option value="ADMIN"    ${selectedRole == 'ADMIN'    ? 'selected' : ''}>Admin</option>
                    <option value="COMPANY"  ${selectedRole == 'COMPANY'  ? 'selected' : ''}>Company</option>
                    <option value="WORKHAND" ${selectedRole == 'WORKHAND' ? 'selected' : ''}>Workhand</option>
                </select>
                <input type="text" name="search" placeholder="Search by name..." value="${search}"
                       style="background:#fff; border:1px solid #ced4da; color:#333;
                              border-radius:8px; padding:8px 12px; font-size:13px; outline:none; flex:1; min-width:180px;">
                <button type="submit" class="custom-btn" style="padding:8px 20px; font-size:13px;">
                    <i class="fas fa-search" style="margin-right:4px;"></i>Filter
                </button>
                <a href="${pageContext.request.contextPath}/admin/users"
                   style="background:#fff; border:1px solid #ced4da; color:#666;
                          border-radius:8px; padding:8px 14px; font-size:13px; text-decoration:none;">Reset</a>
            </div>
        </form>

        <!-- Table -->
        <div style="background:#fff; border-radius:12px; border:1px solid #e9ecef;
                    box-shadow:0 2px 8px rgba(0,0,0,.06); overflow:hidden;">
            <div style="overflow-x:auto;">
                <table style="width:100%; border-collapse:collapse; font-size:13px;">
                    <thead>
                        <tr style="background:#ffbe30;">
                            <th style="padding:12px 16px; color:#1c1c2e; font-size:11px; font-weight:700;
                                       text-transform:uppercase; letter-spacing:.6px; white-space:nowrap;">#</th>
                            <th style="padding:12px 16px; color:#1c1c2e; font-size:11px; font-weight:700;
                                       text-transform:uppercase; letter-spacing:.6px;">Name</th>
                            <th style="padding:12px 16px; color:#1c1c2e; font-size:11px; font-weight:700;
                                       text-transform:uppercase; letter-spacing:.6px;">Username</th>
                            <th style="padding:12px 16px; color:#1c1c2e; font-size:11px; font-weight:700;
                                       text-transform:uppercase; letter-spacing:.6px;">Email</th>
                            <th style="padding:12px 16px; color:#1c1c2e; font-size:11px; font-weight:700;
                                       text-transform:uppercase; letter-spacing:.6px;">Role</th>
                            <th style="padding:12px 16px; color:#1c1c2e; font-size:11px; font-weight:700;
                                       text-transform:uppercase; letter-spacing:.6px;">Location</th>
                            <th style="padding:12px 16px; color:#1c1c2e; font-size:11px; font-weight:700;
                                       text-transform:uppercase; letter-spacing:.6px; text-align:center;">Status</th>
                            <th style="padding:12px 16px; color:#1c1c2e; font-size:11px; font-weight:700;
                                       text-transform:uppercase; letter-spacing:.6px; text-align:center;">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty users.content}">
                                <tr>
                                    <td colspan="8" style="text-align:center; color:#aaa; padding:40px;">
                                        <i class="fas fa-users-slash" style="font-size:30px; display:block; margin-bottom:10px; color:#ccc;"></i>
                                        No users found.
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="u" items="${users.content}" varStatus="loop">
                                    <tr style="border-bottom:1px solid #f0f0f0;">
                                        <td style="padding:11px 16px; color:#aaa; font-size:12px;">${(currentPage - 1) * 10 + loop.index + 1}</td>
                                        <td style="padding:11px 16px;">
                                            <div style="display:flex; align-items:center; gap:10px;">
                                                <c:choose>
                                                    <c:when test="${not empty u.profilePath}">
                                                        <img src="${pageContext.request.contextPath}${u.profilePath}"
                                                             style="width:34px; height:34px; border-radius:50%; object-fit:cover;
                                                                    border:2px solid #ffbe30;" alt="${u.name}">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="width:34px; height:34px; border-radius:50%; background:#f0f0f0;
                                                                     display:inline-flex; align-items:center; justify-content:center;
                                                                     color:#aaa; font-size:13px; border:2px solid #e0e0e0;">
                                                            <i class="fas fa-user"></i>
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                                <span style="font-weight:600; color:#1c1c2e;">${u.name}</span>
                                            </div>
                                        </td>
                                        <td style="padding:11px 16px; color:#888; font-size:12px;">@${u.username}</td>
                                        <td style="padding:11px 16px; font-size:12px; color:#555;">${u.email}</td>
                                        <td style="padding:11px 16px;">
                                            <c:choose>
                                                <c:when test="${u.role.roleName == 'ADMIN'}">
                                                    <span style="background:#f8d7da; color:#721c24;
                                                                 border-radius:20px; padding:2px 10px; font-size:11px; font-weight:600;">Admin</span>
                                                </c:when>
                                                <c:when test="${u.role.roleName == 'COMPANY'}">
                                                    <span style="background:#fff3cd; color:#856404;
                                                                 border-radius:20px; padding:2px 10px; font-size:11px; font-weight:600;">Company</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="background:#cce5ff; color:#004085;
                                                                 border-radius:20px; padding:2px 10px; font-size:11px; font-weight:600;">Workhand</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="padding:11px 16px; font-size:12px; color:#888;">
                                            <c:if test="${u.city != null}">${u.city.cityName},&nbsp;</c:if>
                                            <c:if test="${u.state != null}">${u.state.stateName}</c:if>
                                        </td>
                                        <td style="padding:11px 16px; text-align:center;">
                                            <c:choose>
                                                <c:when test="${u.isActive == 1}">
                                                    <span style="background:#d4edda; color:#155724;
                                                                 border-radius:20px; padding:2px 10px; font-size:11px; font-weight:600;">Active</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="background:#f8f9fa; color:#888;
                                                                 border-radius:20px; padding:2px 10px; font-size:11px;">Inactive</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="padding:11px 16px; text-align:center; white-space:nowrap;">
                                            <form action="${pageContext.request.contextPath}/admin/users/${u.userId}/toggle"
                                                  method="POST" style="display:inline-block;">
                                                <c:choose>
                                                    <c:when test="${u.isActive == 1}">
                                                        <button type="submit"
                                                                style="background:#f8d7da; border:1px solid #f5c6cb; color:#721c24;
                                                                       border-radius:6px; padding:5px 10px; font-size:13px;
                                                                       cursor:pointer; min-width:32px;"
                                                                onclick="return confirm('Deactivate ${u.name}?')"
                                                                title="Deactivate">
                                                            <i class="fas fa-ban"></i>
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button type="submit"
                                                                style="background:#d4edda; border:1px solid #c3e6cb; color:#155724;
                                                                       border-radius:6px; padding:5px 10px; font-size:13px;
                                                                       cursor:pointer; min-width:32px;"
                                                                onclick="return confirm('Activate ${u.name}?')"
                                                                title="Activate">
                                                            <i class="fas fa-check"></i>
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Pagination -->
        <c:if test="${users.totalPages > 1}">
            <div style="display:flex; justify-content:center; gap:6px; margin-top:24px; flex-wrap:wrap;">
                <c:choose>
                    <c:when test="${users.first}">
                        <span style="background:#f8f9fa; border:1px solid #dee2e6;
                                     color:#aaa; border-radius:8px; padding:6px 12px; font-size:13px;">
                            <i class="fas fa-chevron-left"></i>
                        </span>
                    </c:when>
                    <c:otherwise>
                        <a href="?page=${users.number - 1}&role=${selectedRole}&search=${search}"
                           style="background:#fff; border:1px solid #dee2e6; color:#555;
                                  border-radius:8px; padding:6px 12px; font-size:13px; text-decoration:none;">
                            <i class="fas fa-chevron-left"></i>
                        </a>
                    </c:otherwise>
                </c:choose>
                <c:forEach var="pg" items="${totalPageList}">
                    <a href="?page=${pg - 1}&role=${selectedRole}&search=${search}"
                       style="background:${pg == currentPage ? '#ffbe30' : '#fff'};
                              color:${pg == currentPage ? '#1c1c2e' : '#555'};
                              border:1px solid ${pg == currentPage ? '#ffbe30' : '#dee2e6'};
                              border-radius:8px; padding:6px 12px; font-size:13px;
                              font-weight:${pg == currentPage ? '700' : '400'};
                              text-decoration:none;">${pg}</a>
                </c:forEach>
                <c:choose>
                    <c:when test="${users.last}">
                        <span style="background:#f8f9fa; border:1px solid #dee2e6;
                                     color:#aaa; border-radius:8px; padding:6px 12px; font-size:13px;">
                            <i class="fas fa-chevron-right"></i>
                        </span>
                    </c:when>
                    <c:otherwise>
                        <a href="?page=${users.number + 1}&role=${selectedRole}&search=${search}"
                           style="background:#fff; border:1px solid #dee2e6; color:#555;
                                  border-radius:8px; padding:6px 12px; font-size:13px; text-decoration:none;">
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>

    </div>
</section>
