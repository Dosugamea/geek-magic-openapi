
import "../lib/shared-models.tsp";
import "@typespec/openapi3";
import "@typespec/http";

using TypeSpec.Http;
namespace SharedModels;

@doc("interval in seconds between 1 and 2147483647 (actually it has no validation and makes overflow)")
@minValue(1)
@maxValue(2147483647)
scalar IntervalSecondValue extends numeric;

@doc("interval in minutes between 1 and 2147483647 (actually it has no validation and makes overflow)")
@minValue(1)
@maxValue(2147483647)
scalar IntervalMinuteValue extends numeric;

@doc("1 if enabled, 0 if disabled (this api doesn't use boolean)")
enum BooleanLikeNumberValue {
    ENABLED: 1,
    DISABLED: 0,
}

@doc("HTML color in hex")
@example("#FFFFFF")
@pattern("^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$")
scalar HtmlColorValue extends string;

model GetDeviceStorageInfoResponse {
    @doc("total storage size in bytes")
    @example(3121152)
    total: numeric;

    @doc("free storage size in bytes")
    @example(97804)
    free: numeric;
}

@example(#{
    contentType: "text/html",
    body: """
<table id='list'>
<tbody>
    <tr>
        <th>#</th>
        <th>Name</th>
        <th>Size(KB)</th>
        <th></th>
        <th></th>
    </tr>
    <tr>
        <td>1</td>
        <td>
            <a href='/image//ezgif-1-795e37b516.jpg'>ezgif-1-795e37b516.jpg</a>
        </td>
        <td>21</td>
        <td>
            <input type='button' class='btndel' onclick="deletef('/image//ezgif-1-795e37b516.jpg')" value='Delete'>
        </td>
        <td>
            <input type='button' class='btndel' onclick="setgif('/image//ezgif-1-795e37b516.jpg')" value='Set'>
        </td>
    </tr>
    <tr>
        <td>2</td>
        <td>
            <a href='/image//ezgif-2-05016cc8ce.jpg'>ezgif-2-05016cc8ce.jpg</a>
        </td>
        <td>19</td>
        <td>
            <input type='button' class='btndel' onclick="deletef('/image//ezgif-2-05016cc8ce.jpg')" value='Delete'>
        </td>
        <td>
            <input type='button' class='btndel' onclick="setgif('/image//ezgif-2-05016cc8ce.jpg')" value='Set'>
        </td>
    </tr>
    <tr>
        <td>3</td>
        <td>
            <a href='/image//ezgif-3-d2f3e68a3c.jpg'>ezgif-3-d2f3e68a3c.jpg</a>
        </td>
        <td>23</td>
        <td>
            <input type='button' class='btndel' onclick="deletef('/image//ezgif-3-d2f3e68a3c.jpg')" value='Delete'>
        </td>
        <td>
            <input type='button' class='btndel' onclick="setgif('/image//ezgif-3-d2f3e68a3c.jpg')" value='Set'>
        </td>
    </tr>
    <tr>
        <td>4</td>
        <td>
            <a href='/image//ezgif-3-de29a3740c.gif'>ezgif-3-de29a3740c.gif</a>
        </td>
        <td>266</td>
        <td>
            <input type='button' class='btndel' onclick="deletef('/image//ezgif-3-de29a3740c.gif')" value='Delete'>
        </td>
        <td>
            <input type='button' class='btndel' onclick="setgif('/image//ezgif-3-de29a3740c.gif')" value='Set'>
        </td>
    </tr>
    <tr>
        <td>5</td>
        <td>
            <a href='/image//ezgif-4-fe80648c36.jpg'>ezgif-4-fe80648c36.jpg</a>
        </td>
        <td>20</td>
        <td>
            <input type='button' class='btndel' onclick="deletef('/image//ezgif-4-fe80648c36.jpg')" value='Delete'>
        </td>
        <td>
            <input type='button' class='btndel' onclick="setgif('/image//ezgif-4-fe80648c36.jpg')" value='Set'>
        </td>
    </tr>
    <tr>
        <td>6</td>
        <td>
            <a href='/image//ezgif-5-9ed6b4baec.jpg'>ezgif-5-9ed6b4baec.jpg</a>
        </td>
        <td>24</td>
        <td>
            <input type='button' class='btndel' onclick="deletef('/image//ezgif-5-9ed6b4baec.jpg')" value='Delete'>
        </td>
        <td>
            <input type='button' class='btndel' onclick="setgif('/image//ezgif-5-9ed6b4baec.jpg')" value='Set'>
        </td>
    </tr>
    <tr>
        <td>7</td>
        <td>
            <a href='/image//ezgif-5-acf59aa68c.gif'>ezgif-5-acf59aa68c.gif</a>
        </td>
        <td>18</td>
        <td>
            <input type='button' class='btndel' onclick="deletef('/image//ezgif-5-acf59aa68c.gif')" value='Delete'>
        </td>
        <td>
            <input type='button' class='btndel' onclick="setgif('/image//ezgif-5-acf59aa68c.gif')" value='Set'>
        </td>
    </tr>
    <tr>
        <td>8</td>
        <td>
            <a href='/image//ezgif-5-b48d7832df.jpg'>ezgif-5-b48d7832df.jpg</a>
        </td>
        <td>24</td>
        <td>
            <input type='button' class='btndel' onclick="deletef('/image//ezgif-5-b48d7832df.jpg')" value='Delete'>
        </td>
        <td>
            <input type='button' class='btndel' onclick="setgif('/image//ezgif-5-b48d7832df.jpg')" value='Set'>
        </td>
    </tr>
    <tr>
        <td>9</td>
        <td>
            <a href='/image//ezgif-6-7a462b453f.jpg'>ezgif-6-7a462b453f.jpg</a>
        </td>
        <td>18</td>
        <td>
            <input type='button' class='btndel' onclick="deletef('/image//ezgif-6-7a462b453f.jpg')" value='Delete'>
        </td>
        <td>
            <input type='button' class='btndel' onclick="setgif('/image//ezgif-6-7a462b453f.jpg')" value='Set'>
        </td>
    </tr>
    <tr>
        <td>10</td>
        <td>
            <a href='/image//spaceman.gif'>spaceman.gif</a>
        </td>
        <td>61</td>
        <td>
            <input type='button' class='btndel' onclick="deletef('/image//spaceman.gif')" value='Delete'>
        </td>
        <td>
            <input type='button' class='btndel' onclick="setgif('/image//spaceman.gif')" value='Set'>
        </td>
    </tr>
</tbody>
</table>
"""
})
model GetFileListResponse {
    @header contentType: "text/html";

    @body
    @doc("file list info in html table")
    body: string;
}

@doc("image path value (weird but second separater is '//')")
@example("/image//ezgif-3-d2f3e68a3c.jpg")
scalar ImagePathValue extends string;

model UploadFileRequest {
    @header contentType: "multipart/form-data";
    @format("binary")
    file: string;
}